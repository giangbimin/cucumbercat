class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      if @user.authenticate(params[:password])
        flash[:cuccess] = "welcome back #{@user.name}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:error] = 'wrong password'
        redirect_to action: 'new', show_hint: true
      end
    else
      flash.now[:error] = 'user not found'
      redirect_to action: 'new', show_hint: true
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { success: 'logged out' }
  end
end
