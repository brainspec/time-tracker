class SessionsController < ApplicationController
  def create
    raise auth_hash.to_yaml
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
