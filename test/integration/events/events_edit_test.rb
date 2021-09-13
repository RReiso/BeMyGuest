require 'test_helper'

class EventsEditTest < ActionDispatch::IntegrationTest
  require 'test_helper'

  def setup
    @user = users(:one)
    @event = events(:event_one)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get user_event_path(@user, @event)
    assert_template 'events/show'
    assert_select 'a', 'Edit'
    patch user_event_path(@user, @event),
          params: {
            event: {
              name: "Grandma's birthday",
              event_date: '2021-10-09',
              event_time: 'Not a time',
              place: 'My home'
            }
          }
    follow_redirect!
    assert_template 'events/show'
    assert_not flash.empty?
    assert_select 'div.alert-danger', 'Error updating event. Please try again.'
  end

  test 'successful edit' do
    log_in_as(@user)
    get user_event_path(@user, @event)
    assert_template 'events/show'
    assert_select 'a', 'Edit'
    patch user_event_path(@user, @event),
          params: {
            event: {
              name: "Grandma's birthday",
              event_date: '2021-10-09',
              event_time: '2021-10-09 12:30:00 UTC',
              place: 'My home'
            }
          }
    follow_redirect!
    assert_template 'events/show'
    assert flash.empty?
    @event.reload
  end
end
