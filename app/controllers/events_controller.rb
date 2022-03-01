class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @group = @event.group
    @usergroups = UserGroup.where('group_id = ?', @group.id)
    @users = @usergroups.map do |ug|
      ug.user
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
  end

  def destroy
    @event.destroy

    redirect_to events_path(@event.event_user)
  end

  def my_events
    @events = Event.all.where("group_id = ?", current_user.id)
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location)
  end
end
