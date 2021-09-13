module ConnectionsHelper
  def in_guest_list?(contact, event)
    connection =
      Connection.where(contact_id: contact.id).where(event_id: event.id)
    connection.blank? ? false : true
  end

  def rsvp_options
    ['not invited', 'waiting for reply', 'confirmed', 'declined', 'not sure']
  end

  def connection(guest, event)
    Connection.where(contact_id: guest.id).where(event_id: event.id).first
  end
end
