require "test_helper"

class ItemTest < ActiveSupport::TestCase
 def setup
		@user = users(:one)
		@event = events(:event_one)
		@item = @event.items.create(name: 'Chocolate cake')
	end

	test 'should be valid' do
		assert @item.valid?
	end

	test 'name should be present' do
		@item.name = ' '
		assert_not @item.valid?
	end

	test 'event_id should be present' do
		@item.event_id = ' '
		assert_not @item.valid?
	end

end
