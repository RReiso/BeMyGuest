require 'test_helper'

class EventsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @event = events(:event_one)
  end

  test 'successful delete' do
    log_in_as(@user)
    get user_event_path(@user, @event)
    assert_template 'events/show'
    assert_select 'a', 'Edit'
    assert_difference 'Event.count', -1 do
      delete user_event_path(@user, @event)
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert_select 'div.alert-success', 'Event deleted!'
  end
end
