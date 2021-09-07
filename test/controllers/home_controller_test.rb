require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "BeMyGuest"
  end

  test "should get index" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

end
