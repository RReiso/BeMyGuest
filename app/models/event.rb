class Event < ApplicationRecord
  belongs_to :user
   validates :name, presence: true, length: { maximum: 40 }
   validates :user_id, presence: true
   validates :place, length: { maximum: 40 }
   
end
