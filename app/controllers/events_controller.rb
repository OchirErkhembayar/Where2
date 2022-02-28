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
  end

  def create
  end

end
