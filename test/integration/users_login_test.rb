require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
 test "login with invalid information" do
get login_path
assert_template 'home/index'
post root_path, params: { session: { email: "", password:
"" } }
assert_template 'home/index'
assert_not flash.empty?
get contact_path
assert flash.empty?
end

end
