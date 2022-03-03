class EventsController < ApplicationController
  def index
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
      @events.reject! { |event| event.end_date >= Date.today }
      @events.sort_by! { |event| event.end_date } if @events.length > 0
    end
  end

  def show
    @event = Event.find(params[:group_id])
    if EventUser.where('user_id = ? AND event_id = ?', current_user.id, @event.id).empty? && UserGroup.where('user_id = ? AND group_id = ?', current_user.id, @event.group.id).empty?
      redirect_to root_path, alert: "Naughty.. Not for your eyes."
    end
    @group = @event.group
    @usergroups = UserGroup.where('group_id = ? AND status = ?', @group.id, true)
    @users = @usergroups.map do |ug|
      ug.user
    end
    @memberids = @users.map { |user| user.id }
    @eventusers = EventUser.where('event_id = ? AND status = ?', @event.id, true)
    @messages = Event.where('event_id = ?', @event_id)
    @message = Message.new
    @event_user = EventUser.new
  end

  def new
    @event = Event.new
    @group = Group.find(params[:group_id])
  end

  def create
    @event = Event.new(set_event)
    @group = Group.find(params[:group_id])
    @event.group = @group
    if @event.save
      redirect_to "/groups/#{@event.id}/events/#{@group.id}"
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(set_event)
    @event.save
    redirect_to "/groups/#{@event.id}/events/#{@event.group.id}"
  end

  def destroy
    @event = Event.find(params[:event])
    @event.destroy
    redirect_to "/groups/#{@event.group.id}"
  end

  def my_events
    @events = Event.all.where("group_id = ?", current_user.id)
  end

  private

  def set_event
    params.require(:event).permit(:name, :location, :description, :start_date, :end_date, photos: [])
  end
end
