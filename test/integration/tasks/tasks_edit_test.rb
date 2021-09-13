require 'test_helper'

class TasksEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @event = events(:event_one)
    log_in_as(@user)
    get user_event_tasks_path(@user, @event)
    assert_template 'tasks/index'
    post user_event_tasks_path(@user, @event),
         params: {
           task: {
             description: 'Sing a song'
           }
         }
    follow_redirect!
    @task = @event.tasks.first
  end

  test 'unsuccessful edit' do
    patch user_event_task_path(@user, @event, @task),
          params: {
            task: {
              description: ''
            }
          }
    follow_redirect!
    assert_template 'tasks/index'
    assert_not flash.empty?
    assert_select 'div.alert-danger', 'Error updating task. Please try again.'
  end

  test 'successful edit' do
    patch user_event_task_path(@user, @event, @task),
          params: {
            task: {
              description: 'Buy candles'
            }
          }
    follow_redirect!
    assert_template 'tasks/index'
    assert flash.empty?
    @task.reload
  end
end
