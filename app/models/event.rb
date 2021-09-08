class Event < ApplicationRecord
	belongs_to :user
	has_many :tasks, dependent: :destroy
	has_many :items, dependent: :destroy
	has_many :contact_connections,
	         class_name: 'Connection',
	         foreign_key: 'event_id',
	         dependent: :destroy
	has_many :guests, through: :contact_connections, source: :contact

	validates :name, presence: true, length: { maximum: 40 }
	validates :user_id, presence: true
	validates :event_time, presence: true
	validates :event_date, presence: true
	validates :place, length: { maximum: 40 }, presence: true

	def send_invitation(contact) #follow(anotheruser)
		guests << contact
	end

	def cancel_invitation(contact) # unfollow(other_user)
		guests.delete(contact)
	end

	def invited?(contact)
		guests.include?(contact)
	end
end
