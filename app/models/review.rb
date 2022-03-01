class Review < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :event, :user, presence: true
  validates :rating, inclusion: { in: 0..5 }
end
