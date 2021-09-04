class EventsController < ApplicationController
  before_action :require_user_logged_in, only: %i[create show update destroy]
  before_action :require_correct_user, only: %i[create show update destroy]
def create
    event=@user.events.create(event_params)
    if event.save
      redirect_to user_event_path(@user,event)
    else
      render 'users/show'
    end
end
  def show
      	@event = Event.find(params[:id])
  end

 def update
  	@event = Event.find(params[:id])
 flash[:danger]='Error updating event. Please try again.' unless  @event.update(event_params)
redirect_to user_event_path(@user,@event)
end

private

def event_params
      params
        .require(:event)
        .permit(:name, :event_date, :event_time, :place)
    end
end
