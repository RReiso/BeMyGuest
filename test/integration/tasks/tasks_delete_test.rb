require 'test_helper'

class TasksDeleteTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:one)
		@event = events(:event_one)
		log_in_as(@user)
		get user_event_tasks_path(@user, @event)
		assert_template 'tasks/index'
		post user_event_tasks_path(@user, @event),
		     params: {
				task: {
					description: 'Sing a song',
				},
		     }
		follow_redirect!
		@task = @event.tasks.first
	end

	test 'successful delete' do
		assert_select 'a.btn-close'
		assert_difference 'Task.count', -1 do
			delete user_event_task_path(@user, @event, @task)
		end
		follow_redirect!
		assert_template 'tasks/index'
		assert flash.empty?
	end
end
