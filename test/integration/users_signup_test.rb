require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
  # assert_equal before_count, after_count is same as:
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
      email: "user@invalid",
      password: "123",
      password_confirmation: "xxx" } }
    end
    assert_template 'registrations/new'
  end
end
