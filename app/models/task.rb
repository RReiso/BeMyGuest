class Task < ApplicationRecord
  belongs_to :event
  validates :description, presence: true
  validates :completed, inclusion: { in: [true, false] }
end
