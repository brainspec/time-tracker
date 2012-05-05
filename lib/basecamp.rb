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

  def project(id)
    request("/projects/#{id}")
  end

  def todo(project_id, id)
    request("/projects/#{project_id}/todos/#{id}")
  end

  private

  def connection
    @connection ||= Faraday.new(:url => 'https://basecamp.com/') do |builder|
      builder.request :json
      builder.response :logger
      builder.response :mashify
      builder.response :json, :content_type => /\bjson$/
      builder.use :instrumentation
      builder.adapter Faraday.default_adapter
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
