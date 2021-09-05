class TasksController < ApplicationController
	before_action :require_user_logged_in, only: %i[index create update destroy]
	before_action :require_correct_user, only: %i[index create update destroy]
	before_action :require_correct_event, only: %i[index create update destroy]
	before_action :get_task, only: %i[update destroy]

	def index
		@tasks = Task.where(event_id: params[:event_id])
		@new_task = Task.new
	end

	def create
		task = @event.tasks.create(task_params)
		flash[:danger] = 'Error creating task. Please try again.' unless task.save

		redirect_to user_event_tasks_path(@user, @event)
	end

	def update
		flash[:danger] = 'Error updating task. Please try again.' unless @task
			.update(task_params)

		redirect_to user_event_tasks_path(@user, @event)
	end

	def destroy
		@task.destroy
		redirect_to user_event_tasks_path(@user, @event)
	end

	private

	def task_params
		params.require(:task).permit(:description)
	end

	def get_task
		@task = Task.find_by(id: params[:id])
	end
end
