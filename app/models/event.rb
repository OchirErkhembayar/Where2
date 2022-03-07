class Event < ApplicationRecord
  belongs_to :group
  has_many :event_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favourite_events, dependent: :destroy
  has_many_attached :photos
  validates :name, :description, :location, :start_date, :end_date, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  has_one_attached :event_photo
end
