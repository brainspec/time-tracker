class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_user

  helper_method :current_user

  private

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  rescue Mongoid::Errors::DocumentNotFound
    session.clear

    nil
  end

  def require_user
    redirect_to new_session_path unless current_user
  end
end
