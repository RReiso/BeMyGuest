class TasksController < ApplicationController
  before_action :require_user_logged_in, only: %i[index create update destroy]
  before_action :require_correct_user, only: %i[index create update destroy]
   before_action :require_correct_event, only: %i[index create update destroy]

    def index
      @tasks =  Task.where(event_id: params[:event_id])
    end
  def create
  end
  def update
  end
  def destroy
  end

  private

  def task_params
      params
        .require(:task)
        .permit(:description)
    end
end
