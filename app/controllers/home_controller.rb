class HomeController < ApplicationController
  def index
    if current_user
      conn = Faraday.new(:url => 'https://basecamp.com/') do |builder|
        builder.response :logger
        builder.use Faraday::Request::JSON
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
        builder.adapter  :net_http
      end

      response = conn.get do |req|
        req.url "/#{ENV['ACCOUNT_ID']}/api/v1/people/me.json"
        req.headers['Authorization'] = "Bearer #{@current_user.token}"
        req.headers['User-Agent'] = "TimeTracker"
      end

      response = conn.get do |req|
        req.url "/#{ENV['ACCOUNT_ID']}/api/v1/people/#{response.body.id}/assigned_todos.json"
        req.headers['Authorization'] = "Bearer #{@current_user.token}"
        req.headers['User-Agent'] = "TimeTracker"
      end

      @todo_lists = response.body
    end
  end

  def access_denied
    redirect_to root_url if request.ip == ENV['OFFICE_IP']
  end
end
