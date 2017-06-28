class HomeController < ApplicationController
  before_action :require_login

  def index
    @conversations = Conversation.order_by_messages
    @conversation = @conversations.first
  end

  def add_friends
    @friends = current_user.friends
  end

  def users_list
    @users = User.all
  end

  def block_list
    @blockers = current_user.blockers
  end
end
