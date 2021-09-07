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
				task: {
					checked: 'true',
				},
		     },
		     xhr: true # for Ajax requests (works without if head :no content in controller)
		@task.reload
		get user_event_tasks_path(@user, @event)
		assert_template 'tasks/index'
		assert_select 'input.check-box' do
			assert_select '[data-checked=?]', 'true'
		end
	end

  test 'unsuccessful state change' do
		post user_event_task_path(@user, @event, @task),
		     params: {
				task: {
					content: 'something else'
				},
		     }
		@task.reload
		get user_event_tasks_path(@user, @event)
		assert_template 'tasks/index'
		assert_select 'input.check-box' do
			assert_select '[data-checked=?]', 'false'
		end
	end
end
