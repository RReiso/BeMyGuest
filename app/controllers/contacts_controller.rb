class ContactsController < ApplicationController
	before_action :require_user_logged_in, only: %i[index update destroy]
	before_action :require_correct_user, only: %i[index update destroy]
  
	def index; end

	def update; end

	def destroy; end
end
