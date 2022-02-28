class GroupsController < ApplicationController
  def index
    @usergroups = UserGroup.where('user_id = ?', current_user)
  end

  def show
    @group = Group.find(params[:id])
    @usergroups = UserGroup.where('group_id = ?', @group.id)
    @events = Event.where('group_id = ?', @group.id)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
