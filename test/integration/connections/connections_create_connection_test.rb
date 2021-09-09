require "test_helper"

class ConnectionsCreateConnectionTest < ActionDispatch::IntegrationTest
  def setup
		@user = users(:one)
		@event = events(:event_one)
    @contact = contacts(:one)
	end

	test 'invalid create connection information' do
		log_in_as(@user)
		get contact_list_path(@user, @event)
		assert_template 'connections/contact_list'
		assert_select 'input.btn' do
			assert_select '[value=?]', 'Add to guest list'
		end
		# assert_equal before_count, after_count is same as:
		assert_no_difference 'Connection.count' do
			post user_event_connections_path(@user, @event),
			     params: {
						contact: {
					invited: [123],
				},
			     }
		end
		follow_redirect!
		assert_template 'connections/index'
		assert_not flash.empty?
		assert_select 'div.alert-danger', 'Error adding guests. Please try again.'
	end

  	test 'valid create connection information' do
		log_in_as(@user)
		get contact_list_path(@user, @event)
		assert_template 'connections/contact_list'
		assert_select 'input.btn' do
			assert_select '[value=?]', 'Add to guest list'
		end
		# assert_equal before_count, after_count is same as:
		assert_difference 'Connection.count', 1 do
			post user_event_connections_path(@user, @event),
			     params: {
						contact: {
					invited: [@contact.id],
				},
			     }
		end
		follow_redirect!
		assert_template 'connections/index'
    
		assert flash.empty?
	end
end
