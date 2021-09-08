require 'test_helper'

class ContactsEditTest < ActionDispatch::IntegrationTest
	require 'test_helper'

	def setup
		@user = users(:one)
		@contact = contacts(:one)
	end

	test 'unsuccessful edit' do
		log_in_as(@user)
		get user_contacts_path(@user)
		assert_template 'contacts/index'
		assert_select 'a', 'Edit'
		patch user_contact_path(@user, @contact),
		      params: {
				contact: {
					name: '',
					email: 'granny@g.com',
					phone: '123456789',
					notes: "My mom's mom",
				},
		      }
		follow_redirect!
		assert_template 'contacts/index'
		assert_not flash.empty?
		assert_select 'div.alert-danger',
		              'Error updating contact. Please try again.'
	end

	test 'successful edit' do
		log_in_as(@user)
		get user_contacts_path(@user)
		assert_template 'contacts/index'
		assert_select 'a', 'Edit'
		patch user_contact_path(@user, @contact),
		      params: {
				contact: {
					name: 'Granny',
					email: 'granny@g.com',
					phone: '123456789',
					notes: "My mom's mom",
				},
		      }
		follow_redirect!
		assert_template 'contacts/index'
		assert flash.empty?
		@contact.reload
	end
end
