class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @invitations = UserGroup.where('user_id = ? AND status = ?', current_user.id, false)
      @eventinvitations = EventUser.where('user_id = ? AND status = ?', current_user.id, false)
      @notification_count = @invitations.size + @eventinvitations.size
      @friendship_requests = Friendship.where('friend_two_id = ? AND confirmed = ?', current_user.id, false)
      @friend_count = @friendship_requests.size
      @myeventusers = EventUser.where('user_id = ? AND status = ?', current_user.id, true)
      @groups = []
      @events = []
      @myeventusers.each do |eu| # Adds all events that i've been invited to
        @events << Event.find(eu.event_id)
      end
      #check all groups that i'm in
      @usergroups = UserGroup.where('user_id = ?', current_user.id)
      @usergroups.each do |ug|
        @groups << Group.find(ug.group_id)
      end
      #find all events linked to groups that i'm in
      @groups.each do |g|
        Event.where('group_id = ?', g.id).each do |e|
          @events << e
        end
      end
      if @events.length > 0
        @events.reject! { |event| event.end_date <= Date.today }
        @events.sort_by! { |event| event.start_date } if @events.length > 0
      end
      @events = @events.first(5)

      # FRIENDS
      @friendship_requests = Friendship.where('friend_two_id = ? AND confirmed = ?', current_user.id, false)
      @friendships_notaccepted = Friendship.where('friend_two_id = ? OR friend_one_id = ?', current_user.id, current_user.id)
      if @friendships_notaccepted.length.positive?
        @friendships = @friendships_notaccepted.select { |fs| fs.confirmed == true }
        @friendships_pending = @friendships_notaccepted.select { |fs| fs.confirmed == false }
      end
      if @friendships && @friendships.length.positive?
        @two_is_friends = @friendships.select { |f| f.friend_one_id == current_user.id } # friend_two_id is friend
        @one_is_friends = @friendships.select { |f| f.friend_two_id == current_user.id } # friend_one_id is friend
      end
      @friendship = Friendship.new
    end
  end
end
