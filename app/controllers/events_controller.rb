class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
    @group = @event.group
    @usergroups = UserGroup.where('group_id = ?', @group.id)
    @users = @usergroups.map do |ug|
      ug.user
    end
    raise
  end

  def new
  end

  def create
  end

end
