class Friendship < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :friend_one_id
  belongs_to :user, class_name: 'User', foreign_key: :friend_two_id

  def friend_one
    User.find(friend_one_id)
  end

  def friend_two
    User.find(friend_two_id)
  end
end
