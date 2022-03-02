class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:group_id])
    @group = @event.group
    @usergroups = UserGroup.where('group_id = ? AND status = ?', @group.id, true)
    @users = @usergroups.map do |ug|
      ug.user
    end
    @eventusers = EventUser.where('event_id = ? AND status = ?', @event.id, true)
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
    params.require(:event).permit(:name, :location, :description, :start_date, :end_date)
  end
end
