class GroupsController < ApplicationController
  def index
    @usergroups = UserGroup.where('user_id = ?', current_user.id).where('status = ?', true)
  end

  def show
    @group = Group.find(params[:id])
    @usergroups = UserGroup.where('group_id = ? AND status = ?', @group.id, true)
    @users = @usergroups.map do |ug|
      ug.user
    end
    @events = Event.where('group_id = ?', @group.id)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(set_group)
    @group.user = current_user
    @usergroup = UserGroup.new
    @usergroup.user = current_user
    @usergroup.status = true
    if @group.save
      @usergroup.group = @group
      @usergroup.save!
      redirect_to '/groups'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_group
    params.require(:group).permit(:name)
  end
end
