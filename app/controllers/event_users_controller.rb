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
    @event = Event.find(params[:format])
    @group = Group.find(@event.group_id)
    params[:event_user][:user_id].select { |i| i != "" }.each do |id|
      @eventuser = EventUser.new
      @user = User.find(id)
      @eventuser.event = @event
      @eventuser.user = @user
      unless @eventuser.save
        render :new
      end
    end
    redirect_to "/groups/#{@event.id}/events/#{@group.id}"
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
    if @eventuser.user_id == current_user.id
      redirect_to "/"
    else
      redirect_to "/groups/#{@eventuser.event.id}/events/#{@eventuser.event.group.id}"
    end
  end
end
