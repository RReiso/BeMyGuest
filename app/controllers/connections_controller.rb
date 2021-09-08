class ConnectionsController < ApplicationController
	before_action :require_user_logged_in,
	              only: %i[index contact_list create destroy]
	before_action :require_correct_user,
	              only: %i[index contact_list create destroy]
	before_action :require_correct_event,
	              only: %i[index contact_list create destroy]

	def index
		@guests = @event.guests.order('LOWER(name)')
		@connections = Connection.where(event_id: params[:event_id])
	end

	def contact_list
		@new_connection = Connection.new
		@contacts = @user.contacts.order('LOWER(name)')
	end

	def create
		if !params[:contact].blank?
			guests = Contact.where(id: contact_params[:invited])
			guests.each do |guest|
				@event.send_invitation(guest)
				Connection
					.where(contact_id: guest.id)
					.where(event_id: @event.id)
					.first
					.update(RSVP: 'waiting for reply')
			end
			redirect_to guests_path(@user, @event)
		else
			redirect_to contact_list_path(@user)
		end
	end

	def destroy
		guest = Contact.find(params[:id])
		@event.cancel_invitation(guest)
		redirect_to guests_path(@user, @event)
	end

	private

	def contact_params
		params.require(:contact).permit(invited: [])
	end
end
# "task"=>{"description"=>"bb"}
#  "contact"=>{"invited"=>["13", "14"]}
