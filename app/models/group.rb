class Group < ApplicationRecord
  belongs_to :user
  has_many :group_notifications, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  validates :name, presence: true
end
