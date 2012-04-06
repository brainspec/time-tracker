class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :verify_ip_address!
  before_filter :require_user

  helper_method :current_user

  private

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  rescue Mongoid::Errors::DocumentNotFound
    session.clear

    nil
  end

  def verify_ip_address!
    unless request.ip == ENV['OFFICE_IP'] || rendered_403?
      redirect_to '/403'
    end
  end

  def require_user
    redirect_to new_session_path unless current_user || rendered_403?
  end

  def rendered_403?
    action_name == 'access_denied' && controller_name == 'home'
  end
end
