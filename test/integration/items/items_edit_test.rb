require 'test_helper'

class ItemsEditTest < ActionDispatch::IntegrationTest
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

  test 'unsuccessful edit' do
    patch user_event_item_path(@user, @event, @item),
          params: {
            item: {
              name: ''
            }
          }
    follow_redirect!
    assert_template 'items/index'
    assert_not flash.empty?
    assert_select 'div.alert-danger', 'Error updating item. Please try again.'
  end

  test 'successful edit' do
    patch user_event_item_path(@user, @event, @item),
          params: {
            item: {
              name: 'Chocolate cake'
            }
          }
    follow_redirect!
    assert_template 'items/index'
    assert flash.empty?
    @item.reload
  end
end
