class ChanelsController < ApplicationController
  before_action :require_login

  def index
    @chanels = current_user.chanels
  end

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

  def display
    @messages = Message.chanel_messages(current_user.id, params[:id])
    @messages.update(read_status: true)
    respond_to :js
  end
end
