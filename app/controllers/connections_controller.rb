class ConnectionsController < ApplicationController
  before_action :require_user_logged_in,
                only: %i[index contact_list create update destroy]
  before_action :require_correct_user,
                only: %i[index contact_list create update destroy]
  before_action :require_correct_event,
                only: %i[index contact_list create update destroy]

  def index
    @guests = @event.guests.order('LOWER(name)')
    @connections = Connection.where(event_id: params[:event_id])
  end

  def contact_list
    @new_connection = Connection.new
    @contacts = @user.contacts.order('LOWER(name)')
  end

  def create
    if params[:contact].blank?
      redirect_to contact_list_path(@user)
    else
      invite_guests
      redirect_to guests_path(@user, @event)
    end
  end

  def update
    connection = Connection.find(params[:id])
    connection.update(rsvp_params)
    redirect_to guests_path(@user, @event)
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

  def rsvp_params
    params.require(:connection).permit(:RSVP)
  end

  def invite_guests
    guests = Contact.where(id: contact_params[:invited])
    if guests.blank?
      flash[:danger] = 'Error adding guests. Please try again.'
    else
      guests.each do |guest|
        flash[:danger] = 'Error adding guest. Please try again.' unless @event
          .send_invitation(guest)
      end
    end
  end
end
