class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "hi #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.messages.to_s
      render 'new'
    end
  end

  def block
    friend = User.find(params[:friend_id])
    User.transaction do
      # for querry in models we using inverse
      Friendship.find_by(user: friend, friend: current_user).update(blocked: true)
    end
  end

  def un_block
    friend = User.find(params[:friend_id])
    User.transaction do
      Friendship.find_by(user: friend, friend: current_user).update(blocked: false)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :gender)
  end
end
