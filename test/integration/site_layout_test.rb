require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do # your name for test
    get root_path
    assert_template 'home/index'
    assert_select "a[href=?]", root_path # , count: 3
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
  end
end
