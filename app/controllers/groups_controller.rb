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
      redirect_to "/groups/#{@group.id}"
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(set_group)
    if @group.save
      redirect_to "/groups/#{@group.id}"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to "/groups"
  end

  private

  def set_group
    params.require(:group).permit(:name)
  end
end
