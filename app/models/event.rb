class Event < ApplicationRecord
  belongs_to :group
  has_many :event_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favourite_events, dependent: :destroy
  validates :name, :description, :location, :start_date, :end_date, presence: true
  has_many :messages
end
