class ItemsController < ApplicationController
  before_action :require_user_logged_in,
                only: %i[index create update_item_state destroy]
  before_action :require_correct_user,
                only: %i[index create update_item_state destroy]
  before_action :require_correct_event,
                only: %i[index create update_item_state destroy]
  before_action :item, only: %i[update_item_state destroy]

  def index
    @items = Item.where(event_id: params[:event_id])
    @new_item = Item.new
  end

  def create
    new_item = @event.items.create(item_params)
    flash_danger('creating', 'item') unless new_item.save
    redirect_to user_event_items_path(@user, @event)
  end

  def update_item_state
    @item.update(item_checked_params)
    head :no_content
  end

  def destroy
    @item.destroy
    redirect_to user_event_items_path(@user, @event)
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

  def item_checked_params
    params.require(:item).permit(:checked)
  end

  def item
    @item = Item.find_by(id: params[:id])
  end
end
