module ConnectionsHelper
	def in_guest_list?(contact)
		connection =
			Connection.where(contact_id: contact.id).where(event_id: @event.id)
		in_guest_list = connection.blank? ? false : true
		in_guest_list
	end

	def rsvp_options
		['not invited', 'waiting for reply', 'confirmed', 'declined', 'not sure']
	end

  # def guest(connection)
  #   Contact.find_by(id: connection.contact_id)
  # end

  def connection(guest)
    Connection.where(contact_id: guest.id).where(event_id:@event.id).first
  end
end
