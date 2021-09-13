require 'test_helper'

class ItemsChangeitemStateTest < ActionDispatch::IntegrationTest
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

  test 'successful state change' do
    patch update_item_state_path(@user, @event, @item),
          params: {
            item: {
              checked: 'true'
            }
          },
          xhr: true # for Ajax requests (works without if head :no content in controller)
    @item.reload
    get user_event_items_path(@user, @event)
    assert_template 'items/index'
    assert_select 'input.check-box' do
      assert_select '[data-checked=?]', 'true'
    end
  end

  test 'unsuccessful state change' do
    patch update_item_state_path(@user, @event, @item),
          params: {
            item: {
              content: 'something else'
            }
          }
    @item.reload
    get user_event_items_path(@user, @event)
    assert_template 'items/index'
    assert_select 'input.check-box' do
      assert_select '[data-checked=?]', 'false'
    end
  end
end
