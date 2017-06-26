class HomeController < ApplicationController
  before_action :require_login

  def index
    @friends = User.where.not('id = ?', current_user.id).order('created_at DESC')
    @friend = current_user
    @conversations = Conversation.involving(current_user).order('created_at DESC')
    @page = 10
  end

  # def load_friends
  #   @friends = User.where.not('id = ?', current_user.id).order('created_at DESC')
  #   @conversation = Conversation.self_conversation(current_user.id) || Conversation.create(sender_id: current_user.id, recipient_id: current_user.id)
  # end

  # def load_users
  #   @users = User.where.not(id: User.is_friends.ids)
  #   @conversation = Conversation.self_conversation(current_user.id) || Conversation.create(sender_id: current_user.id, recipient_id: current_user.id)
  # end
end
