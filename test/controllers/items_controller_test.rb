require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @event = events(:event_one)
    @second_user = users(:two)
    @base_title = 'BeMyGuest'
    @item = items(:one)
  end

  test 'should get index' do
    log_in_as(@user)
    get user_event_items_path(@user, @event)
    assert_response :success
    assert_select 'title', "Shopping | #{@base_title}"
  end

  test 'should redirect index when logged in as wrong user' do
    log_in_as(@second_user)
    get user_event_items_path(@user, @event)
    assert flash.empty?
    assert_redirected_to @second_user
  end

  test 'should redirect index when not logged in' do
    get user_event_items_path(@user, @event)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_event_item_path(@user, @event, @item),
          params: {
            item: {
              name: 'Chocolate cake'
            }
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@second_user)
    patch user_event_item_path(@user, @event, @item),
          params: {
            item: {
              name: 'Chocolate cake'
            }
          }
    assert flash.empty?
    assert_redirected_to @second_user
  end

  test 'should redirect create when not logged in' do
    post user_event_items_path(@user, @event),
         params: {
           item: {
             name: 'Chocolate cake'
           }
         }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect create when logged in as wrong user' do
    log_in_as(@second_user)
    post user_event_items_path(@user, @event),
         params: {
           item: {
             name: 'Chocolate cake'
           }
         }
    assert flash.empty?
    assert_redirected_to @second_user
  end

  test 'should redirect change item state when not logged in' do
    patch update_item_state_path(@user, @event, @item),
          params: {
            item: {
              checked: 'true'
            }
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect change item state when logged in as wrong user' do
    log_in_as(@second_user)
    patch update_item_state_path(@user, @event, @item),
          params: {
            item: {
              checked: 'true'
            }
          }
    assert flash.empty?
    assert_redirected_to @second_user
  end
end
