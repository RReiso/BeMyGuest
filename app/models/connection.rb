class Connection < ApplicationRecord
    belongs_to :contact, class_name: "Contact"
  belongs_to :event, class_name: "Event"
  validates :contact_id, presence: true
  validates :event_id, presence: true
end
