require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get home/index" do
    get login_path
    assert_response :success
  end
end
