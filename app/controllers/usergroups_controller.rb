class UsergroupsController < ApplicationController
  def index
    @invitations = UserGroup.where('user_id = ? AND status = ?', current_user.id, false)
    @eventinvitations = EventUser.where('user_id = ? AND status = ?', current_user.id, false)
  end

  def new
    @group = Group.find(params[:group_id])
    @usergroup = UserGroup.new
  end

  def create
    @usergroup = UserGroup.new
    @group = Group.find(params[:group_id])
    @usergroup.user_id = params[:user_group][:user_id].to_i
    @usergroup.group = @group
    if @usergroup.save
      redirect_to "/groups/#{@group.id}"
    else
      render :new
    end
  end

  def accept
    @usergroup = UserGroup.find(params[:id])
    @usergroup.status = true
    if @usergroup.save
      redirect_to "/groups/#{@usergroup.group.id}"
    else
      render :index
    end
  end

  def destroy
    @usergroup = UserGroup.find(params[:id])
    @usergroup.destroy
    redirect_to "/usergroups"
  end

  private

  def set_usergroup
    params.require[:user_group]
  end
end
