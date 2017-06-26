class ConversationsController < ApplicationController
  layout false

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    render json: { conversation_id: @conversation.id }
  end

  def display
    @user_id = params[:user_id]
    @friend_id = params[:friend_id]
    @conversation = Conversation.between(@user_id, @friend_id).first.try(:messages)
    @conversation ||= Conversation.create(sender_id: @user_id, recipient_id: @friend_id)
    respond_to :js
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
