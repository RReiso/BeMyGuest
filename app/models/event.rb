class Event < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :items, dependent: :destroy

   validates :name, presence: true, length: { maximum: 40 }
   validates :user_id, presence: true
   validates :event_time, presence: true
   validates :event_date, presence: true
   validates :place, length: { maximum: 40 }, presence: true
   
end
