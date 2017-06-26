class HomeController < ApplicationController
  before_action :require_login

  def index
    @users = User.where.not('id = ?', current_user.id).order('created_at DESC')
    @conversations = Conversation.involving(current_user).order('created_at DESC')
    @page = 10
    @conversation = Conversation.self_conversation(current_user.id) || Conversation.create(sender_id: current_user.id, recipient_id: current_user.id)
  end
end
