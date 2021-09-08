class ConnectionsController < ApplicationController
	before_action :require_user_logged_in,
	              only: %i[index contact_list create destroy]
	before_action :require_correct_user,
	              only: %i[index contact_list create destroy]
	before_action :require_correct_event,
	              only: %i[index contact_list create destroy]

	def index; end

	def contact_list
		@new_connection = Connection.new
		@contacts = @user.contacts.order('LOWER(name)')
	end

	def create
		if !params[:contact].blank?
			invitees = Contact.where(id: contact_params[:invited])
			invitees.each { |invitee| @event.send_invitation(invitee) }
      redirect_to guests_path(@user, @event)
    else
      redirect_to contact_list_path(@user)
		end
	end

	# def destroy
	# 	user = Relationship.find(params[:id]).followed
	# 	current_user.unfollow(user)
	# 	redirect_to user
	# end

	private

	def contact_params
		params.require(:contact).permit(invited: [])
	end
end
# "task"=>{"description"=>"bb"}
#  "contact"=>{"invited"=>["13", "14"]}
