class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @invitations = UserGroup.where('user_id = ? AND status = ?', current_user.id, false)
      @eventinvitations = EventUser.where('user_id = ? AND status = ?', current_user.id, false)
      @notification_count = @invitations.size + @eventinvitations.size
    end
  end
end
