class EventUsersController < ApplicationController
  def index
    @event_users = EventUser.where('event_id = ?', current_event.id)
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
    @event_user = EventUser.find(params[:event_id])
    @event_user.status = true
    if @event_user.save
      redirect_to "/events"
    else
      render :index
    end
  end
end
