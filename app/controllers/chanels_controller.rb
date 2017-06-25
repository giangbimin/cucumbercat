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

  def add_member
    @chanel = Chanel.find_by(params[:id])
    if @chanel.chanel_type == 'private'
      new_chanel = chanel.create
      new_chanel.user_chanels.create(@chanel.users.last.id)
      new_chanel.user_chanels.create(@chanel.users.first.id)
      new_chanel.user_chanels.create(params[:recipient_id])
      new_chanel.chanel_type = 'group'
      new_chanel.save
      @chanel = new_chanel
    end
    if @chanel.chanel_type == 'group'
      @chanel.user_chanels.create(params[:recipient_id])
    end
    render :js
  end

  def display
    @messages = Message.chanel_messages(current_user.id, params[:id])
    @messages.update(read_status: true)
    respond_to :js
  end
end
