class Item < ApplicationRecord
  belongs_to :event
  default_scope { order(id: :asc) }
  validates :event_id, presence: true
	validates :name, presence: true
end
