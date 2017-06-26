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
    @friend = User.find(params[:recipient_id])
    @conversation = Conversation.between(@user_id, @friend.id).first
    @conversation ||= Conversation.create(sender_id: @user_id, recipient_id: @friend_id)
    @page = 10
    respond_to :js
  end

  def load_more
    @conversation = Conversation.find(params[:conversation_id])
    @page = params[:page].to_i
    @page += 10
    respond_to :js
  end

  def destroy
    @conversation = Conversation.find(params[:conversation_id])
    if Message.where(conversation_id: @conversation.id, user_id: current_user.id).destroy_all
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'all your messsages in the conversation had destroyed.' }
      end
    end
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
