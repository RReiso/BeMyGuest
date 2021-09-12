require 'test_helper'

class EventsSaveNotesTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:one)
		log_in_as(@user)
		get user_path(@user)
		assert_template 'users/show'
		post user_events_path(@user),
		     params: {
				event: {
					name: "Grandma's birthday",
					event_date: '2021-10-09',
					event_time: '2021-10-09 12:30:00 UTC',
					place: 'My home',
				},
		     }
		follow_redirect!
		@event = @user.events.where(name: "Grandma's birthday").first
	end

	test 'successful save' do
		assert_template 'events/show'
		assert_select 'h4.card-title', "Grandma's birthday"
		assert_select 'textarea#sticky-note'
		post notes_path(@user, @event),
		     params: {
				id: @event.id,
				event: {
					notes: 'Pirate theme',
				},
		     }
		@event.reload
		get user_event_path(@user, @event)
		assert_template 'events/show'
		assert_select 'textarea#sticky-note', 'Pirate theme'
	end
end
