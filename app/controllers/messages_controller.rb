class MessagesController < ApplicationController
  def create
    @message = @conversation.messages.create(message_params)
    @message.user_id = current_user.id
    if @message.save
      respond_to :js
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
