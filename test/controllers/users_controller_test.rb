require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @second_user = users(:two)
    @base_title = "BeMyGuest"
  end
  
  test "should show user" do
    log_in_as(@user)
    get user_url(@user)
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should redirect show when not logged in" do
get user_path(@user)
assert_not flash.empty?
assert_redirected_to login_url
end

test "should redirect update when not logged in" do
patch user_path(@user), params: { user: { 
password:"1234abcd",
password_confirmation: "1234abcd" } } 
assert_not flash.empty?
assert_redirected_to login_url
end

test "should redirect show when logged in as wrong user" do
log_in_as(@second_user)
get user_path(@user)
assert flash.empty?
assert_redirected_to root_url
end

test "should redirect update when logged in as wrong user" do
log_in_as(@second_user)
patch user_path(@user), params: { user: { 
password:"1234abcd",
password_confirmation: "1234abcd" } }
assert flash.empty?
assert_redirected_to root_url
end


 
end
