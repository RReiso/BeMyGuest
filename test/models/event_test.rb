require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @birthday =
      @user.events.create(
        name: "Grandma's birthday",
        event_date: '2021-10-09',
        event_time: '2021-10-09 12:30:00 UTC',
        place: 'My home',
        notes: 'Remind guests that Grandma can not hear well.'
      )
  end

  test 'should be valid' do
    assert @birthday.valid?
  end

  test 'name should be present' do
    @birthday.name = ' '
    assert_not @birthday.valid?
  end

  test 'user_id should be present' do
    @birthday.user_id = ' '
    assert_not @birthday.valid?
  end

  test 'place should be present' do
    @birthday.place = ' '
    assert_not @birthday.valid?
  end

  test 'place should not be too long' do
    @birthday.place = 'x' * 41
    assert_not @birthday.valid?
  end
end
