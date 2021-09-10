class EventsController < ApplicationController
	before_action :require_user_logged_in, only: %i[create show update save_notes destroy]
	before_action :require_correct_user, only: %i[create show update save_notes destroy]
	before_action :require_correct_event, only: %i[show update save_notes destroy]

	def create
		event = @user.events.create(event_params)
		if event.save
			redirect_to user_event_path(@user, event)
		else
			redirect_to @user, danger:'Error creating event. Please try again.'
		end
	end

	def show; end

	def update
		flash[:danger] = 'Error updating event. Please try again.' unless @event
			.update(event_params)
		redirect_to user_event_path(@user, @event)
	end

  def save_notes
  end

	def destroy
		@event.destroy
		redirect_to @user, success: 'Event deleted!'
	end

	private

	def event_params
		params.require(:event).permit(:name, :event_date, :event_time, :place)
	end
end
