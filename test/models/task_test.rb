require 'test_helper'

class TaskTest < ActiveSupport::TestCase
	def setup
		@user = users(:one)
		@event = events(:event_one)
		@task = @event.tasks.create(description: 'Buy tickets')
	end

	test 'should be valid' do
		assert @task.valid?
	end

	test 'description should be present' do
		@task.description = ' '
		assert_not @task.valid?
	end

	test 'event_id should be present' do
		@task.event_id = ' '
		assert_not @task.valid?
	end
end
