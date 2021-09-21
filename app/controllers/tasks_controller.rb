class TasksController < ApplicationController
  before_action :require_user_logged_in,
                only: %i[index create update_task_state destroy]
  before_action :require_correct_user,
                only: %i[index create update_task_state destroy]
  before_action :require_correct_event,
                only: %i[index create update_task_state destroy]
  before_action :task, only: %i[update_task_state destroy]

  def index
    @tasks = Task.where(event_id: params[:event_id])
    @new_task = Task.new
  end

  def create
    new_task = @event.tasks.create(task_params)
    flash_danger('creating', 'task') unless new_task.save
    redirect_to user_event_tasks_path(@user, @event)
  end

  def update_task_state
    @task.update(task_checked_params)
    head :no_content
  end

  def destroy
    @task.destroy
    redirect_to user_event_tasks_path(@user, @event)
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

  def task_checked_params
    params.require(:task).permit(:checked)
  end

  def task
    @task = Task.find_by(id: params[:id])
  end
end
