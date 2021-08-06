require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get "/"
    assert_response :success
    assert_select "h1", "Flawless Events"
  end
end
