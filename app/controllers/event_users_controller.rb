class EventUsersController < ApplicationController
  def index
    @event_users = EventUser.where('user_id = ? AND status = ?', current_user.id, true)
    if @event_users.size > 0
      @event_users = @event_users.reject { |event| event.event.end_date <= Date.today }
      @event_users = @event_users.sort_by { |event| event.event.end_date } if @event_users.size > 0
    end
    @myusergroups = UserGroup.where('user_id = ? AND status = ?', current_user.id, true)
    @groups = []
    @myusergroups.each do |ug|
      @groups << Group.find(ug.group_id)
    end
    @events = []
    @groups.each do |ug|
      Event.where('group_id = ?', ug.id).each do |event|
        @events << event
      end
    end
    if @events.length > 0
      @events.reject! { |event| event.end_date <= Date.today }
      @events.sort_by! { |event| event.end_date } if @events.length > 0
    end
  end
  def new
    @event_user = EventUser.new
    @event = Event.find(params[:event_id])
    @group = Group.find(@event.group_id)
  end

  def create
    @event_user = EventUser.new
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @event_user.user_id = params[:event_user][:user_id]
    @event_user.event = @event
    if @event_user.save
      redirect_to "/groups/#{@event.id}/events/#{@group.id}"
    else
      render :new
    end
  end

  def accept
    @eventuser = EventUser.find(params[:id])
    @eventuser.status = true
    if @eventuser.save
      redirect_to "/groups/#{@eventuser.event.id}/events/#{@eventuser.event.group.id}"
    else
      render :index
    end
  end

  def destroy
    @eventuser = EventUser.find(params[:id])
    @eventuser.destroy
    redirect_to root_path
  end
end
