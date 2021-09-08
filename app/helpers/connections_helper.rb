module ConnectionsHelper
  def rsvp(contact)
    connection = Connection.where(contact_id: contact.id).where(event_id: @event.id)
    rsvp = connection.blank? ? "not-invited" : connection.first.RSVP
    rsvp
  end
end
