class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_groups, dependent: :destroy
  has_many :favourite_events, dependent: :destroy
  has_one :group
  has_many :friendships
  has_one_attached :photo

  def friends
    friendships = Friendship.where('friend_one_id = ? OR friend_two_id = ?', self.id, self.id)
    first_one = friendships.select { |fs| fs.confirmed == true && (fs.friend_one != self && fs.friend_two == self)}
    second_one = friendships.select { |fs| fs.confirmed == true && (fs.friend_one == self && fs.friend_two != self)}
    @friends = first_one.map { |fs| User.find(fs.friend_one.id)}
    second_one.each { |fs| @friends << User.find(fs.friend_two.id) }
    @friends
  end

  def friends_first_names
    friends.map { |f| f.first_name }
  end

  def event_user_invites(event)
    friendships = Friendship.where('friend_one_id = ? OR friend_two_id = ?', self.id, self.id)
    first_one = friendships.select { |fs| fs.confirmed == true && (fs.friend_one != self && fs.friend_two == self)}
    second_one = friendships.select { |fs| fs.confirmed == true && (fs.friend_one == self && fs.friend_two != self)}
    @friends = first_one.map { |fs| User.find(fs.friend_one.id)}
    second_one.each { |fs| @friends << User.find(fs.friend_two.id) }
    @eventusers = EventUser.where('event_id = ?', event.id).map { |eu| eu.user }
    @users = UserGroup.where('group_id = ?', event.group.id).map { |ug| ug.user }
    @friends = @friends.reject { |f| @eventusers.include? f }
    @friends.reject { |f| @users.include? f }
  end

  def user_group_invites(group)
    friendships = Friendship.where('friend_one_id = ? OR friend_two_id = ?', self.id, self.id)
    first_one = friendships.select { |fs| fs.confirmed == true && (fs.friend_one != self && fs.friend_two == self)}
    second_one = friendships.select { |fs| fs.confirmed == true && (fs.friend_one == self && fs.friend_two != self)}
    @friends = first_one.map { |fs| User.find(fs.friend_one.id)}
    second_one.each { |fs| @friends << User.find(fs.friend_two.id) }
    @users = UserGroup.where('group_id = ?', group.id).map { |ug| ug.user }
    @friends.reject { |f| @users.include? f }
  end
end
