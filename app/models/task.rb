class Task < ApplicationRecord
  belongs_to :event
  validates :description, presence: true
end
