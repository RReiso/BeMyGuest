class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :require_correct_user

	def index #users/nr/activities (user_activities_path(user))
		@events = Events.where(user_id: params[:user_id])
	end
end
