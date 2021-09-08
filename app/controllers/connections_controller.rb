class ConnectionsController < ApplicationController
  	before_action :require_user_logged_in, only: %i[index contact_list create destroy]
	before_action :require_correct_user, only: %i[index contact_list create destroy]
	before_action :require_correct_event, only: %i[index contact_list create destroy]

  def index
  end

  def contact_list
    @new_connection = Connection.new
    @contacts = @user.contacts.order('LOWER(name)')
  end


	def create
		new_invitee = User.find(params[:followed_id])
		@event.send_invitation(new_invitee)
		redirect_to guests_path(@user,@event)
	end

	# def destroy
	# 	user = Relationship.find(params[:id]).followed
	# 	current_user.unfollow(user)
	# 	redirect_to user
	# end
end
