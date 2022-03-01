class EventUsersController < ApplicationController
  def index
    @event_users = EventUser.where('event_id = ?', current_event.id),where('status = ?', true)
  end

  def new
    @event_user = EventUser.new
    # @event.set_user!(current_user)
    # if @event_user == current_user
    #   redirect_to '/forms'
    # else
    #   redirect_to events_path(@event_id)
    # end
  end

  def show
    @event = Event.find(params[:id])
    @event_users = EventUsers.where('event_id = ?', @event_users.id)
    @event_users = @event_users.map do |eu|
      eu.event_user
    end
  end

  def create
    @event_users = EventUser.new(set_event_users)
    @event_USER.user = current_user
    @event_user = EventUser.new
    @usergroup.user = current_user
    @event_user.accepted = true
    if @event_user.save
      @event_user.event = @event
      @usergroup.save!
      redirect_to '/forms'
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


  def set_event_users
    params.require(:event_user).permit(:event_id)
  end
  end
