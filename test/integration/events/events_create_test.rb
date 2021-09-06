require "test_helper"

class EventsCreateTest < ActionDispatch::IntegrationTest
 
def setup
@user = users(:one)
end

	test 'invalid create event information' do
		log_in_as(@user)
get user_path(@user)
assert_template 'users/show'
assert_select 'a', '+ New'
		# assert_equal before_count, after_count is same as:
		assert_no_difference 'Event.count' do
			post user_events_path(@user), params:
			      { event: { 
name: "Grandma's birthday",
        event_date: '2021-10-09',
        event_time: 'Not a time',
        place: 'My home' } }
		end
    follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
    assert_select 'div.alert-danger', 'Error creating event. Please try again.'
	end

	test 'valid create event information' do
	log_in_as(@user)
get user_path(@user)
assert_template 'users/show'
assert_select 'a', '+ New'
		# assert_equal before_count, after_count is same as:
		assert_difference 'Event.count', 1 do
			post user_events_path(@user), params:
			      { event: { 
name: "Grandma's birthday",
        event_date: '2021-10-09',
        event_time: '2021-10-09 12:30:00 UTC',
        place: 'My home' } }
		end
		follow_redirect!
		assert_template 'events/show'
		assert flash.empty?
	end


end
