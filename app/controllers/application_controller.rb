class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_user

  def require_user
    if current_user.blank?
      redirect_to new_session_url, notice: "Must be signed in for that."
    end
  end

  helper_method :signed_in?
  helper_method :current_user

  def signed_in?
    return session[:user_id].present?
  end

  def current_user
    return @user ||= User.find_by_id(session[:user_id])
  end
end
