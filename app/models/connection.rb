class Connection < ApplicationRecord
	RSVP_OPTIONS = [
		'not invited',
		'waiting for reply',
		'confirmed',
		'declined',
		'not sure',
	]
	belongs_to :contact
	belongs_to :event
	validates :contact_id, presence: true
	validates :event_id, presence: true
	validates :RSVP, presence: true, inclusion: { in: RSVP_OPTIONS }
end
