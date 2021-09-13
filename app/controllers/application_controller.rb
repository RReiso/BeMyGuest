class ApplicationController < ActionController::Base
	include ApplicationHelper
	include SessionsHelper
	include UsersHelper
	include EventsHelper

	before_action :new_event
	add_flash_types :success, :warning, :danger, :info
end
