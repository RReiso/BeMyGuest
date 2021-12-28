class Contact < ApplicationRecord
  belongs_to :user
  has_many :connections, dependent: :destroy
  has_many :invitations, through: :connections, source: :event

  validates :user_id, presence: true
  validates :name, presence: true
end
