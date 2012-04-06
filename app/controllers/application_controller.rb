class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_user

  private

  def require_user
    @current_user = session[:user_id] && User.find(session[:user_id])
    redirect_to new_session_path unless @current_user
  end
end
