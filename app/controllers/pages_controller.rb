class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @invitations = UserGroup.where('user_id = ? AND status = ?', current_user.id, false)
      @eventinvitations = EventUser.where('user_id = ? AND status = ?', current_user.id, false)
      @notification_count = @invitations.size + @eventinvitations.size
      @friendship_requests = Friendship.where('friend_two_id = ? AND confirmed = ?', current_user.id, false)
      @friend_count = @friendship_requests.size
    end
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
  end
end
