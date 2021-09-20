require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:one)
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
    assert_select 'title', "My Events | #{@base_title}"
  end

  test 'should redirect show when not logged in' do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: { user: {
      password: '1234abcd',
      password_confirmation: '1234abcd'
    } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert flash.empty?
    assert_redirected_to root_path
  end

  test 'should redirect index when logged in and not admin' do
    log_in_as(@second_user)
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

  test 'index as admin with delete links' do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assigns(:users).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_select 'a[href=?]', user_path(user), text: 'delete' unless user == @admin
    end
    assert_difference 'User.count', -1 do
      delete user_path(@second_user)
    end
  end

  test "should not allow the admin attribute to be edited via
the web" do
    log_in_as(@second_user)
    assert_not @second_user.admin?
    patch user_path(@second_user), params: {
      user: { password: '1234abcd', password_confirmation: '1234abcd',
              admin: '1' }
    }
    assert_not @second_user.reload.admin?
  end
end
