class UsergroupsController < ApplicationController
  def index
    @invitations = @usergroup.where('user_id = ?', current_user.id)
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

  private

  def set_usergroup
    params.require[:user_group]
  end
end
