class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def require_login
    redirect_to new_sessions_path, flash: { alert: 'log-in first' } unless user_signed_in?
  end

  def user_signed_in?
    current_user.is_a? User
  end
end
