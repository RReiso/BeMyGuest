require 'test_helper'

class TasksChangeTaskStateTest < ActionDispatch::IntegrationTest
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

	test 'successful state change' do
		post user_event_task_path(@user, @event, @task),
		     params: {
				data: {
					completed: 'true',
				},
		     },
		     xhr: true # for Ajax requests
		@task.reload
		get user_event_tasks_path(@user, @event)
		assert_template 'tasks/index'
		assert_select 'input.check-box' do
			assert_select '[data-completed=?]', 'true'
		end
	end

  test 'unsuccessful state change' do
		post user_event_task_path(@user, @event, @task),
		     params: {
				data: {
					content: 'something else'
				},
		     },
		     xhr: true # for Ajax requests
		@task.reload
		get user_event_tasks_path(@user, @event)
		assert_template 'tasks/index'
		assert_select 'input.check-box' do
			assert_select '[data-completed=?]', 'false'
		end
	end
end
