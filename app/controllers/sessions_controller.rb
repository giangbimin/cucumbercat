class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      flash[:success] = "welcome back #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = 'wrong password or email'
      redirect_to action: 'new', show_hint: true
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { success: 'logged out' }
  end
end
