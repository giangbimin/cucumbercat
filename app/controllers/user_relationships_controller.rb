class UserRelationshipsController < ApplicationController
  before_action :require_login

  def add_friend
    UserRelationship.add_friend(current_user, params[:friend_id])
  end

  def block_friend
    UserRelationship.block_friend(current_user, params[:friend_id])
  end

  def deltete_friend
    UserRelationship.find_by(friend_id, params[:friend_id]).destroy
  end
end
