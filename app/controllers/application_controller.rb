class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :login?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def login?
    current_user.is_a? User
  end

  def require_login
    redirect_to root_path unless login?
  end
end
