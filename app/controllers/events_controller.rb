class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:group_id])
    @group = @event.group
    @usergroups = UserGroup.where('group_id = ?', @group.id)
    @users = @usergroups.map do |ug|
      ug.user
    end
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

  private

  def set_event
    params.require(:event).permit(:name, :location, :description, :start_date, :end_date)
  end
end
