class TasksController < ApplicationController
  before_action :require_user_logged_in, only: %i[index create update destroy]
  before_action :require_correct_user, only: %i[index create update destroy]
   before_action :require_correct_event, only: %i[index create update destroy]

    def index
      @tasks =  Task.where(event_id: params[:event_id])
       @task = Task.find_by(id:params[:id])
    end
  def create
  end
  def update
   
  end
  def destroy
  
    
      @task = Task.find_by(id:params[:id])
    @task.destroy
    redirect_to user_event_tasks_path(@user,@event)

  end

  private

  def task_params
      params
        .require(:task)
        .permit(:description)
    end
end
