class Basecamp
  def initialize(token)
    @token = token
  end

  attr_reader :token

  def assigned_todos
    person = request('/people/me')
    request("/people/#{person.id}/assigned_todos")
  end

  def projects
    request('/projects')
  end

  private

  def connection
    @connection ||= Faraday.new(:url => 'https://basecamp.com/') do |builder|
      builder.response :logger
      builder.use Faraday::Request::JSON
      builder.use FaradayMiddleware::Mashify
      builder.use FaradayMiddleware::ParseJson
      builder.adapter :net_http
    end
  end

  def request(path)
    response = connection.get do |req|
      req.url "/#{ENV['ACCOUNT_ID']}/api/v1#{path}.json"

      req.headers['Authorization'] = "Bearer #{token}"
      req.headers['User-Agent']    = "TimeTracker"
    end

    response.body
  end
end
