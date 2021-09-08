require 'test_helper'

class ContactsDeleteTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:one)
		@contact = contacts(:one)
	end

	test 'successful delete' do
		log_in_as(@user)
		get address_book_path(@user)
		assert_template 'contacts/index'
		assert_select 'a', 'Edit'
		assert_difference 'Contact.count', -1 do
			delete user_contact_path(@user, @contact)
		end
		follow_redirect!
		assert_template 'contacts/index'
		assert flash.empty?
	end
end
