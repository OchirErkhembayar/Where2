class Message < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :content, length: { minimum: 1 }

  def user
    @user = User.find(user_id)
  end
end
