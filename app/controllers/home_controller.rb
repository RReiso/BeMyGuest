class HomeController < ApplicationController
	before_action :require_user_logged_out, only: %i[index]
	def index; end
end
