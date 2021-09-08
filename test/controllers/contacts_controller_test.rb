require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:one)
		@second_user = users(:two)
    @contact = contacts(:one)
		@base_title = 'BeMyGuest'
	end

	test 'should get index' do
		log_in_as(@user)
		get address_book_path(@user)
		assert_response :success
		assert_select 'title', "AddressBook | #{@base_title}"
	end

	test 'should redirect index when logged in as wrong user' do
		log_in_as(@second_user)
		get address_book_path(@user)
		assert flash.empty?
		assert_redirected_to @second_user
	end

	test 'should redirect index when not logged in' do
		get address_book_path(@user)
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test 'should redirect update when not logged in' do
		patch user_contact_path(@user,@contact),
		      params: {
				contact: {
					name: 'Edgar',
					email: 'e@e.lv',
					phone: '123-456',
				},
		      }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test 'should redirect update when logged in as wrong user' do
		log_in_as(@second_user)
		patch user_contact_path(@user, @contact),
		      params: {
				contact: {
					name: 'Edgar',
					email: 'e@e.lv',
					phone: '123-456',
				},
		      }
		assert flash.empty?
		assert_redirected_to @second_user
	end

	test 'should redirect create when not logged in' do
		post user_contacts_path(@user),
		    params: {
				contact: {
					name: 'Edgar',
					email: 'e@e.lv',
					phone: '123-456',
				},
		    }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test 'should redirect create when logged in as wrong user' do
		log_in_as(@second_user)
		post user_contacts_path(@user),
		    params: {
				contact: {
					name: 'Edgar',
					email: 'e@e.lv',
					phone: '123-456',
				},
		    }
		assert flash.empty?
		assert_redirected_to @second_user
	end
end
