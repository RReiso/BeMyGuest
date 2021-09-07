class ContactsController < ApplicationController
	before_action :require_user_logged_in, only: %i[index create update destroy]
	before_action :require_correct_user, only: %i[index create update destroy]
	before_action :get_contact, only: %i[update destroy]

	def index
		@new_contact = Contact.new
		@contacts = @user.contacts.order('LOWER(name)') # Case insensitive ordering
	end

	def create
		contact = @user.contacts.create(contact_params)
		flash[:danger] = 'Error creating contact. Please try again.' unless contact
			.save

		redirect_to address_book_path(@user)
	end

	def update
		flash[:danger] = 'Error updating contact. Please try again.' unless @contact
			.update(contact_params)

		redirect_to address_book_path(@user)
	end

	def destroy
		@contact.destroy
		redirect_to address_book_path(@user)
	end

	private

	def contact_params
		params.require(:contact).permit(:name, :email, :phone, :notes)
	end

	def get_contact
		@contact = Contact.find_by(id: params[:id])
	end
end
