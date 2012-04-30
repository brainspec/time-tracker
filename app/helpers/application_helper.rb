module ApplicationHelper
  def basecamp_url(url)
    url.gsub(/\.json$/, '').gsub('/api/v1', '')
  end

  def project_by_todo_list_url(url)
    @projects ||= Basecamp.new(current_token).projects

    bcx_id = url.match(/\/projects\/(\d+)/).captures.first.to_i
    @projects.find { |p| p.id == bcx_id }
  end
end
