require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase
	def setup
		@event = events(:event_one)
		@contact = contacts(:one)
		@event.send_invitation(@contact)
		@connection =
			Connection.where(contact_id: @contact.id).where(event_id: @event.id).first
	end

	test 'should be valid' do
		assert @connection.valid?
	end

	test 'RSVP should be present' do
		@connection.RSVP = ' '
		assert_not @connection.valid?
	end

  	test 'RSVP should be from RSVP_OPTIONS' do
		@connection.RSVP = 'not coming'
		assert_not @connection.valid?
		@connection.RSVP = 'waiting for reply'
		assert @connection.valid?
	end

	test 'event_id should be present' do
		@connection.event_id = ' '
		assert_not @connection.valid?
	end

  test 'contact_id should be present' do
		@connection.contact_id = ' '
		assert_not @connection.valid?
	end
end
