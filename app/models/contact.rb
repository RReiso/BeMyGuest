class Contact < ApplicationRecord
	belongs_to :user
	has_many :event_connections,
	         class_name: 'Connection',
	         foreign_key: 'contact_id',
	         dependent: :destroy
	has_many :invitations, through: :event_connections, source: :event
  has_many :apples

	validates :user_id, presence: true
	validates :name, presence: true

	# 	def receive_invitation(event) #follow(anotheruser)
	# 		invitations << event
	# 	end

	#   def unfollow(event) # unfollow(other_user)
	# invitations.delete(event)
	# end
end
