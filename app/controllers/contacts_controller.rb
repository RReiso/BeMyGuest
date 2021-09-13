class ContactsController < ApplicationController
  before_action :require_user_logged_in, only: %i[index create update destroy]
  before_action :require_correct_user, only: %i[index create update destroy]
  before_action :contact, only: %i[update destroy]

  def index
    @new_contact = Contact.new
    @contacts = @user.contacts.order('LOWER(name)') # Case insensitive ordering
  end

  def create
    new_contact = @user.contacts.create(contact_params)
    flash_danger('creating', 'contact') unless new_contact.save
    redirect_to user_contacts_path(@user)
  end

  def update
    flash_danger('updating', 'contact') unless @contact.update(contact_params)
    redirect_to user_contacts_path(@user)
  end

  def destroy
    @contact.destroy
    redirect_to user_contacts_path(@user)
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :notes)
  end

  def contact
    @contact = Contact.find_by(id: params[:id])
  end
end
