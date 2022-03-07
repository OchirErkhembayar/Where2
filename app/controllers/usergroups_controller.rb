class UsergroupsController < ApplicationController
  def index
    @invitations = UserGroup.where('user_id = ? AND status = ?', current_user.id, false)
    @eventinvitations = EventUser.where('user_id = ? AND status = ?', current_user.id, false)
    if @eventinvitations.length.positive?
      @eventinvitations = @eventinvitations.reject { |ei| ei.event.end_date <= Date.today }
    end
  end

  def new
    @group = Group.find(params[:group_id])
    @usergroup = UserGroup.new
  end

  def create
    @usergroup = UserGroup.new
    @group = Group.find(params[:group_id])
    user_ids = params[:user_group][:user_id].select { |p| p != "" }
    user_ids.each do |id|
      @usergroup = UserGroup.new
      @usergroup.user = User.find(id)
      @usergroup.group = @group
      unless @usergroup.save
        render :new
      end
    end
    redirect_to "/groups/#{@group.id}"
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
    @usergroup = UserGroup.where('user_id = ? AND group_id = ?', current_user.id, params[:group_id])
    @usergroup.first.destroy
    if @usergroup.first.status == false
      redirect_to "/usergroups"
    else
      redirect_to "/groups"
    end
  end

  def kick
    @usergroup = UserGroup.where('user_id = ? AND group_id = ?', params[:id], params[:group_id]).first
    @usergroup.destroy
    redirect_to "/groups/#{@usergroup.group_id}"
  end

  private

  def set_usergroup
    params.require[:user_group]
  end
end
