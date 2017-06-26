class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    User.transaction do
      Friendship.create!(user: current_user, friend: friend)
      Friendship.create!(user: friend, friend: current_user)
    end
  end
end
