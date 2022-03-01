class GroupsController < ApplicationController
  def index
    @usergroups = UserGroup.where('user_id = ?', current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @usergroups = UserGroup.where('group_id = ?', @group.id)
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
    @usergroup.group = @group
    @usergroup.user = current_user
    @usergroup.save
    if @group.save
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
