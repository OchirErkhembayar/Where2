class EventUsersController < ApplicationController
  def index
    @event_users = EventUser.where('user_id = ? AND status = ?', current_user.id, true)
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
      redirect_to "/groups"
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
