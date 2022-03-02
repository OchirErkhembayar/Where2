class MessagesController < ApplicationController
  def create
    @event = Event.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.event = @event
    @message.user = current_user
    if @message.save
      redirect_to event_path(@event, anchor: "message-#{@message.id}")
    else
      render "events/show"
    end
  end
end
