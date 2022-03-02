class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where('friend_two_id = ? AND confirmed = ?', current_user.id, false)
  end

  def show
  end

  def new
  end

  def create
    @friendship = Friendship.new
    @friendship.friend_one_id = current_user.id
    @friendship.friend_two_id = User.find(params[:user_id]).id
    @friendship.save!
    redirect_to "/"
  end

  def destroy
  end

  def accept
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    @friendship.save
    redirect_to "/"
  end
end
