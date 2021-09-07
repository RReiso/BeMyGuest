class ItemsController < ApplicationController
  before_action :require_user_logged_in,
	              only: %i[index create update update_item_state destroy]
	before_action :require_correct_user,
	              only: %i[index create update update_item_state destroy]
	before_action :require_correct_event,
	              only: %i[index create update update_item_state destroy]
	before_action :get_item, only: %i[update update_item_state destroy]

	def index
		@items = Item.where(event_id: params[:event_id])
		@new_item = Item.new
	end

	def create
		item = @event.items.create(item_params)
		flash[:danger] = 'Error creating item. Please try again.' unless item.save

		redirect_to user_event_items_path(@user, @event)
	end

	def update
		flash[:danger] = 'Error updating item. Please try again.' unless @item
			.update(item_params)

		redirect_to user_event_items_path(@user, @event)
	end

	def update_item_state
		@item.update(item_checked_params)
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
		params.require(:data).permit(:checked)
    
	end

	def get_item
		@item = Item.find_by(id: params[:id])
	end
end
