class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @page = 10
    message = @conversation.messages.build(message_params)
    message.user_id = current_user.id
    if message.save
      respond_to :js
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
