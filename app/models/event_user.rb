class EventUser < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :event, dependent: :destroy

  validates :user_id, presence: true
end
