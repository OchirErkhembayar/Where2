class EventUsersController < ApplicationController
  def index
    @event_users = EventUser.all
  end

  def new
    @event_user = EventUser.new
    @event = Event.find(params[:event_id])
    @group = Group.find(@event.group_id)
  end

  def create
    @event_user = EventUser.new
    @group = Group.find(params[:group_id])
    @user = User.find(params[:event_user][:user_id])
    @event = Event.find(params[:event_id])
    @event_user.user = @user
    @event_user.event = @event
    if @event_user.save
      redirect_to "/groups/#{@event.id}/events/#{@group.id}"
    else
      render :new
    end
  end
end
