class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    unless params[:accept]
      flash[:error] = 'make sure you accepted the firm'
      render 'new'
    end
    if params[:confirm_password] != params[:password]
      flash[:error] = 'make sure about you password confirm is true'
      render 'new'
    end
    @user = User.new(user_params)

    if @user.save
      flash[:error] = 'make sure about you password confirm is true'
      rederect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :confirm_password, :accept)
  end
end
