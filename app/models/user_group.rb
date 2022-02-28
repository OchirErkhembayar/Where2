class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user, :group, presence: true
end
