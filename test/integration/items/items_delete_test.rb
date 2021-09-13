require 'test_helper'

class ItemsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @event = events(:event_one)
    log_in_as(@user)
    get user_event_items_path(@user, @event)
    assert_template 'items/index'
    post user_event_items_path(@user, @event),
         params: {
           item: {
             name: 'Chocolate cake'
           }
         }
    follow_redirect!
    @item = @event.items.first
  end

  test 'successful delete' do
    assert_select 'a.btn-close'
    assert_difference 'Item.count', -1 do
      delete user_event_item_path(@user, @event, @item)
    end
    follow_redirect!
    assert_template 'items/index'
    assert flash.empty?
  end
end
