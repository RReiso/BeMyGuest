require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	def setup
		ActionMailer::Base.deliveries.clear
	end

	test 'invalid signup information' do
		get signup_path

		# assert_equal before_count, after_count is same as:
		assert_no_difference 'User.count' do
			post signup_path,
			     params: {
					user: {
						name: '',
						email: 'user@user',
						password: '123',
						password_confirmation: 'xxx',
						terms_and_conditions: ' ',
					},
			     }
		end
		assert_template 'registrations/new'
		assert_select 'div#error_explanation'
	end

	test 'valid signup information with account activation' do
		get signup_path
		assert_difference 'User.count', 1 do
			post signup_path,
			     params: {
					user: {
						name: 'User User',
						email: 'user@user.com',
						password: '11111111',
						password_confirmation: '11111111',
						terms_and_conditions: '1',
					},
			     }
		end
		assert_equal 1, ActionMailer::Base.deliveries.size
		user = assigns(:user)
		assert_not user.activated?

		# Try to log in before activation.
		log_in_as(user)
		assert_not is_logged_in?

		# Invalid activation token
		get edit_account_activation_path('invalid token', email: user.email)
		assert_not is_logged_in?

		# Valid token, wrong email
		get edit_account_activation_path(user.activation_token, email: 'wrong')
		assert_not is_logged_in?

		# Valid activation token
		get edit_account_activation_path(user.activation_token, email: user.email)
		assert user.reload.activated?
		follow_redirect!
		assert_template 'users/show'
		assert is_logged_in?
	end
end
