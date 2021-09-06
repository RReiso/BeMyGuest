require 'test_helper'

class TasksCreateTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:one)
		@event = events(:event_one)
	end

	test 'invalid create task information' do
		log_in_as(@user)
		get user_event_tasks_path(@user, @event)
		assert_template 'tasks/index'
		assert_select 'input.btn', value: 'Create a task'

		# assert_equal before_count, after_count is same as:
		assert_no_difference 'Event.count' do
			post user_event_tasks_path(@user, @event),
			     params: {
					task: {
						description: '',
					},
			     }
		end
		follow_redirect!
		assert_template 'tasks/index'
		assert_not flash.empty?
		assert_select 'div.alert-danger', 'Error creating task. Please try again.'
	end

	test 'valid create task information' do
		log_in_as(@user)
		get user_event_tasks_path(@user, @event)
		assert_template 'tasks/index'
		assert_select 'input.btn', value: 'Create a task'

		# assert_equal before_count, after_count is same as:
		assert_no_difference 'Event.count' do
			post user_event_tasks_path(@user, @event),
			     params: {
					task: {
						description: 'Sing a song',
					},
			     }
		end
		follow_redirect!
		assert_template 'tasks/index'
		assert flash.empty?
		assert_select 'table.task-table'
    assert_select 'a.btn', 'Edit'
	end
end
