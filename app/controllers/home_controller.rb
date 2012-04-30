require 'basecamp'

class HomeController < ApplicationController
  def index
    @todo_lists = Basecamp.new(current_token).assigned_todos
  end

  def access_denied
    redirect_to root_url if request.ip == ENV['OFFICE_IP']
  end
end
