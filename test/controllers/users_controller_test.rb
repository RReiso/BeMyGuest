require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:one)
		@second_user = users(:two)
		@base_title = 'BeMyGuest'
	end

	test 'should get index' do
		log_in_as(@user)
		get users_path
		assert_response :success
		assert_select 'title', "All Users | #{@base_title}"
	end

	test 'should show user' do
		log_in_as(@user)
		get user_url(@user)
		assert_response :success
		assert_select 'title', "Home | #{@base_title}"
	end

	test 'should redirect show when not logged in' do
		get user_path(@user)
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test 'should redirect update when not logged in' do
		patch user_path(@user),
		      params: {
				user: {
					password: '1234abcd',
					password_confirmation: '1234abcd',
				},
		      }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test 'should redirect index when not logged in' do
		get users_path
		assert flash.empty?
		assert_redirected_to root_path
	end

	test 'should redirect index when logged as a non admin' do
		log_in_as(@second_user)
		assert_not @second_user.admin?
		get users_path
		assert flash.empty?
		assert_redirected_to @second_user
	end

	test 'should redirect show when logged in as wrong user' do
		log_in_as(@second_user)
		get user_path(@user)
		assert flash.empty?
		assert_redirected_to @second_user
	end

	test 'should redirect update when logged in as wrong user' do
		log_in_as(@second_user)
		patch user_path(@user),
		      params: {
				user: {
					password: '1234abcd',
					password_confirmation: '1234abcd',
				},
		      }
		assert flash.empty?
		assert_redirected_to @second_user
	end

	test 'should not allow the admin attribute to be edited via
the web' do
		log_in_as(@second_user)
		assert_not @second_user.admin?
		patch user_path(@second_user),
		      params: {
				user: {
					password: '1234abcd',
					password_confirmation: '1234abcd',
					admin: '1',
				},
		      }
		assert_not @second_user.reload.admin?
	end

	test 'should redirect destroy when not logged in' do
		assert_no_difference 'User.count' do
			delete user_path(@user)
		end
		assert_redirected_to root_url
	end

	test 'should redirect destroy when logged in as a non-admin' do
		log_in_as(@second_user)
		assert_not @second_user.admin?
		assert_no_difference 'User.count' do
			delete user_path(@user)
		end
		assert_redirected_to @second_user
	end

  test "index as non-admin" do
    log_in_as(@second_user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index as admin with delete links" do
log_in_as(@user)
get users_path
assert_template 'users/index'
assert_select 'a[href=?]', user_path(@second_user), text: @second_user.name
assert_select 'a[href=?]', user_path(@second_user), text: 'delete'
assert_difference 'User.count', -1 do
delete user_path(@second_user)
end
end

end
