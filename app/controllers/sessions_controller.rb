class SessionsController < ApplicationController
  skip_before_filter :require_user

  def create
    user = User.find_or_create_by_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
