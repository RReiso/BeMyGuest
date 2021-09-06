class Task < ApplicationRecord
	belongs_to :event
	validates :event_id, presence: true
	validates :description, presence: true
end
