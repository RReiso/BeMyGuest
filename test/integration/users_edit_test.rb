require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
@user = users(:one)
end
test "unsuccessful edit" do
log_in_as(@user)
get user_path(@user)
assert_template 'users/show'
patch user_path(@user), params: { user: { 
password:"123abc",
password_confirmation: "abc123" } }
assert_template 'users/show'
assert_not flash.empty?
assert_select 'div.alert-danger', 'An error occured while changing password. Please try again.'
end


test "successful edit" do
log_in_as(@user)
get user_path(@user)
assert_template 'users/show'
patch user_path(@user), params: { user: {
password:
"aaaaaaaa",
password_confirmation: "aaaaaaaa" } }
assert_not flash.empty?
assert_select 'div.alert-success', 'Password changed!'
assert_template 'users/show'
@user.reload
end

end
