module ApplicationHelper
  def basecamp_url(url)
    url.gsub(/\.json$/, '').gsub('/api/v1', '')
  end

  def project_by_todo_list_url(url)
    @projects ||= begin
      conn = Faraday.new(:url => 'https://basecamp.com/') do |builder|
        builder.response :logger
        builder.use Faraday::Request::JSON
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
        builder.adapter  :net_http
      end

      response = conn.get do |req|
        req.url "/#{ENV['ACCOUNT_ID']}/api/v1/projects.json"
        req.headers['Authorization'] = "Bearer #{@current_user.token}"
        req.headers['User-Agent'] = "TimeTracker"
      end

      response.body
    end

    bcx_id = url.match(/\/projects\/(\d+)/).captures.first.to_i
    @projects.find { |p| p.id == bcx_id }
  end
end
