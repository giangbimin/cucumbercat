class ChanelsController < ApplicationController
  before_action :require_login

  def create
    @sender = current_user
    if Chanel.between(curent_user.id, params[:recipient_id]).present?
      @chanel = Chanel.between(params[:sender_id], params[:recipient_id]).first
    else
      @chanel = Chanel.create
      @chanel.user_chanels.create(current_user.id)
      @chanel.user_chanels.create(params[:recipient_id])
      @chanel.chanel_type = 'private'
      @chanel.save
    end

    render :js
  end

  def show
    @chanel = Chanel.find(params[:id])
    @messages = @chanel.messages.presence || "let's chating"
  end
end
