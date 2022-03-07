class Group < ApplicationRecord
  belongs_to :user
  has_many :group_notifications, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  validates :name, presence: true
  has_one_attached :photo
end
