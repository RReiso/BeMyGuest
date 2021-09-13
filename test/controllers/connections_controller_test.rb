require 'test_helper'

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @event = events(:event_one)
    @second_user = users(:two)
    @contact = contacts(:one)
    @connection = connections(:one)
    @base_title = 'BeMyGuest'
  end

  test 'should get index' do
    log_in_as(@user)
    get guests_path(@user, @event)
    assert_response :success
    assert_select 'title', "Guests | #{@base_title}"
  end

  test 'should redirect index when logged in as wrong user' do
    log_in_as(@second_user)
    get guests_path(@user, @event)
    assert flash.empty?
    assert_redirected_to @second_user
  end

  test 'should redirect index when not logged in' do
    get guests_path(@user, @event)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should get contact-list' do
    log_in_as(@user)
    get contact_list_path(@user, @event)
    assert_response :success
    assert_select 'title', "Contact List | #{@base_title}"
  end

  test 'should redirect contact-list when not logged in' do
    get contact_list_path(@user, @event, @connection)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect contact-list when logged in as wrong user' do
    log_in_as(@second_user)
    get contact_list_path(@user, @event)
    assert flash.empty?
    assert_redirected_to @second_user
  end

  test 'should redirect create when not logged in' do
    post user_event_connections_path(@user, @event),
         params: {
           contact: {
             invited: [@contact.id]
           }
         }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect create when logged in as wrong user' do
    log_in_as(@second_user)
    post user_event_connections_path(@user, @event),
         params: {
           contact: {
             invited: [@contact.id]
           }
         }
    assert flash.empty?
    assert_redirected_to @second_user
  end

  test 'should redirect update when not logged in' do
    patch user_event_connection_path(@user, @event, @connection),
          params: {
            connection: {
              RSVP: 'confirmed'
            }
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@second_user)
    patch user_event_connection_path(@user, @event, @connection),
          params: {
            connection: {
              RSVP: 'confirmed'
            }
          }
    assert flash.empty?
    assert_redirected_to @second_user
  end
end
