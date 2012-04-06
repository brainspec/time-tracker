module ApplicationHelper
  def basecamp_url(url)
    url.gsub(/\.json$/, '').gsub('/api/v1', '')
  end
end
