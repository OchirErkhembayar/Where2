class EventUsersController < ApplicationController
  def index
    @event_users = EventUser.all
  end

  def new
    @event_user = EventUser.new(params[:id])
    @event.set_user!(current_user)
    if @event_user == current_user
      redirect_to '/forms'
    else
      redirect_to events_path(@event_id)
    end
  end
end
