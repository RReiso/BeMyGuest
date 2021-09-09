require 'test_helper'

class ItemsCreateTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:one)
		@event = events(:event_one)
	end

	test 'invalid create item information' do
		log_in_as(@user)
		get user_event_items_path(@user, @event)
		assert_template 'items/index'
		assert_select 'input.btn' do
			assert_select '[value=?]', 'Add item'
		end
		# assert_equal before_count, after_count is same as:
		assert_no_difference 'Item.count' do
			post user_event_items_path(@user, @event),
			     params: {
					item: {
						name: '',
					},
			     }
		end
		follow_redirect!
		assert_template 'items/index'
		assert_not flash.empty?
		assert_select 'div.alert-danger', 'Error creating item. Please try again.'
	end

	test 'valid create item information' do
		log_in_as(@user)
		get user_event_items_path(@user, @event)
		assert_template 'items/index'
		assert_select 'input.btn' do
			assert_select '[value=?]', 'Add item'
		end
		# assert_equal before_count, after_count is one more:
		assert_difference 'Item.count', 1 do
			post user_event_items_path(@user, @event),
			     params: {
					item: {
						name: 'Chocolate cake',
					},
			     }
		end
		follow_redirect!
		assert_template 'items/index'
		assert flash.empty?
		assert_select 'table.object-table'
    assert_select 'a.btn', 'Edit'
	end
end
