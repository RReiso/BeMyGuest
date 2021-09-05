require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
   setup do
    @user = users(:one)
    @event = events(:event_one)
    @second_user = users(:two)
    @base_title = "BeMyGuest"
  end

test "should show event" do
    log_in_as(@user)
    get user_event_url(@user, @event)
    assert_response :success
    assert_select "title", "#{@event.name} | #{@base_title}"
  end

  test "should redirect show when not logged in" do
get user_event_path(@user,@event)
assert_not flash.empty?
assert_redirected_to login_url
end

test "should redirect show when logged in as wrong user" do
log_in_as(@second_user)
get user_event_path(@user,@event)
assert flash.empty?
assert_redirected_to @second_user
end

test "should redirect update when not logged in" do
patch user_event_path(@user,@event), params: { event: { 
name:"Wedding",
event_date: "2021-10-02",
event_time: "2021-10-02 22:00:00" } } 
assert_not flash.empty?
assert_redirected_to login_url


end

end
