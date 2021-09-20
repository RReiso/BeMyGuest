require 'test_helper'

class ConnectionsDeleteTest < ActionDispatch::IntegrationTest
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

  test 'successful delete' do
    assert_template 'connections/index'
    assert_select 'a.text-secondary'
    assert_difference 'Connection.count', -1 do
      delete user_event_connection_path(@user, @event, @connection.contact_id)
    end
    follow_redirect!
    assert_template 'connections/index'
    assert flash.empty?
  end
end
