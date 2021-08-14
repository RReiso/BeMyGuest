require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @base_title = "BeMyGuest"
  end
  
  test "should show user" do
    get user_url(@user)
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  # test "should get show" do
  #   get "/users/1"
  #   assert_response :success
  #   assert_select "title", "Home | #{@base_title}"
  # end

 
end
