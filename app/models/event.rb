class Event < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :connections, dependent: :destroy
  has_many :guests, through: :connections, source: :contact

  validates :name, presence: true
  validates :user_id, presence: true
  validates :event_time, presence: true
  validates :event_date, presence: true
  validates :place, length: { maximum: 40 }, presence: true

  def send_invitation(contact)
    guests << contact
  end

  def cancel_invitation(contact)
    guests.delete(contact)
  end

  def invited?(contact)
    guests.include?(contact)
  end
end
