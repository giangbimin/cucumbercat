class ConversationsController < ApplicationController
  layout false
  before_action :read_messages, only: [:show, :display]

  def index
    redirect_to root_path
  end

  def show
    @conversation = Conversation.includes(:messages).find(params[:id])
    @messages = load_more_message
    respond_to :js
  end

  def create
    @conversation = Conversation.between(params[:sender_id],
                                         params[:recipient_id]).first
    @conversation ||= Conversation.create!(conversation_params)
    respond_to :js
  end

  def display
    @recipient = User.find(params[:recipient_id])
    @conversation = current_user.find_conversation_by(@recipient)
    @conversation ||= Conversation.create(sender: @current_user,
                                          recipient: @recipient)
    @messages = load_more_message
    respond_to :js
  end

  def load_more
    @conversation ||= Conversation.includes(:messages).find(params[:id])
    @messages = load_more_message
    respond_to :js
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    Message.where(conversation: @conversation, user: current_user).destroy_all
    respond_to :js
  end

  private

  def load_more_message
    page = params[:page] || 1
    @conversation.messages.paginate(page: page).order(created_at: :desc).reverse
  end

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end

  def read_messages
    @conversation.messages.update_all(unread: false)
  end
end
