class EventUser < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true

  def users
    EventUser.all.map(&:user)
  end
end
