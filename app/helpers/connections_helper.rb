module ConnectionsHelper
	def rsvp(contact)
		connection =
			Connection.where(contact_id: contact.id).where(event_id: @event.id)
		rsvp = connection.blank? ? 'not-invited' : 'invited'
		rsvp
	end

	def rsvp_options
		['Waiting for reply', 'Confirmed', 'Declined', 'Not sure']
	end
end
