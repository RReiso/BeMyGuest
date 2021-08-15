require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
  # assert_equal before_count, after_count is same as:
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
      email: "user@user",
      password: "123",
      password_confirmation: "xxx" } }
    end
    assert_template 'registrations/new'
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
get signup_path
assert_difference 'User.count', 1 do
post signup_path, params: { user: { name: "User User", email: "user@user.com", password: "11111111",
password_confirmation: "11111111" } }
end
follow_redirect!
assert_template 'users/show'
assert_not flash.empty?
end

end
