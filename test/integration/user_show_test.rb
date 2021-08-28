require "test_helper"

class UserShowTest < ActionDispatch::IntegrationTest
  def setup
    @activated_user  = users(:two)
    @not_activated_user = users(:three)
  end

  test "should redirect when user not activated" do
    log_in_as(@not_activated_user)
    get user_path(@not_activated_user)
    assert_response :redirect
    assert_redirected_to login_url
  end

  test "should display user when activated" do
    log_in_as(@activated_user)
    get user_path(@activated_user)
    assert_response :success
    assert_template "users/show"
  end
end
