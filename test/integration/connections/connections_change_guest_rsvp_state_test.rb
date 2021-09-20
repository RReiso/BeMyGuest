require 'test_helper'

class ConnectionsChangeGuestRsvpStateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:two)
    @event = events(:event_one)
    @contact = contacts(:one)
    log_in_as(@user)
    get contact_list_path(@user, @event)
    post user_event_connections_path(@user, @event),
         params: {
           contact: {
             invited: [@contact.id]
           }
         }
    @connection = Connection.where(contact_id: @contact.id).first
    follow_redirect!
  end

  test 'successful guest rsvp state change' do
    assert_template 'connections/index'
    assert_select 'a.text-secondary'
    patch user_event_connection_path(@user, @event, @connection),
          params: {
            connection: {
              RSVP: 'declined'
            }
          }
    @connection.reload
    follow_redirect!
    assert_template 'connections/index'
    assert_select 'span.text-light-blue', 'declined'
  end

  test 'unsuccessful guest rsvp state change' do
    assert_template 'connections/index'
    assert_select 'a.text-secondary'
    patch user_event_connection_path(@user, @event, @connection),
          params: {
            connection: {
              RSVP: 'something else'
            }
          }
    @connection.reload
    follow_redirect!
    assert_template 'connections/index'
    assert_select 'span.text-light-blue', 'not invited'
  end
end
