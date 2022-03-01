class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user_id, :group_id, presence: true
end
