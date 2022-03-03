class GroupsController < ApplicationController
  def index
    @usergroups = UserGroup.where('user_id = ?', current_user.id).where('status = ?', true)
    @group = Group.new
  end

  def show
    if UserGroup.where('group_id = ? AND user_id = ?', params[:id].to_i, current_user.id).empty?
      redirect_to "/groups", alert: "Naughty, naughty...."
    end
    if Group.where('id = ?', params[:id]).empty?
      redirect_to "/groups"
    else
      @group = Group.find(params[:id])
      @usergroups = UserGroup.where('group_id = ? AND status = ?', @group.id, true)
      @pendingusers = UserGroup.where('group_id = ? AND status = ?', @group.id, false)
      @users = @usergroups.map do |ug|
        ug.user
      end
      @events = Event.where('group_id = ?', @group.id).reject { |event| event.end_date <= Date.today }
      @my_friendships = Friendship.where('friend_one_id = ? OR friend_two_id = ?', current_user.id, current_user.id)
    end
    @events = Event.where('group_id = ?', @group.id).reject { |event| event.end_date <= Date.today }
    @usergroup = UserGroup.new
    @event = Event.new
    @my_friendships = Friendship.where('friend_one_id = ? OR friend_two_id = ?', current_user.id, current_user.id)
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
