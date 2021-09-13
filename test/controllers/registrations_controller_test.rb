require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'BeMyGuest'
  end

  test 'should get new' do
    get signup_path
    assert_response :success
    assert_select 'title', "Sign Up | #{@base_title}"
  end
end
