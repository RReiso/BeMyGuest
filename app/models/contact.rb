class Contact < ApplicationRecord
  belongs_to :user
  has_many :event_connections,
           class_name: 'Connection',
           foreign_key: 'contact_id',
           dependent: :destroy
  has_many :invitations, through: :event_connections, source: :event

  validates :user_id, presence: true
  validates :name, presence: true
end
