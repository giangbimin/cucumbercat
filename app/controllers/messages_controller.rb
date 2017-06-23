class MessagesController < ApplicationController
  before_action :require_login
  before_action :find_chanel

  def create
    @message = current_user.messages.build(message_params)
    @message.chanel_id = @chanel.id
    if @message.save
      render :js
    end
  end

  private

  def find_chanel
    @chanel = Chanel.find(params[:chanel_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
