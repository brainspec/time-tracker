module ApplicationHelper
  def basecamp_url(obj)
    url = obj.respond_to?(:url) ? obj.url : obj.to_s
    url.gsub(/\.json$/, '').gsub('/api/v1', '')
  end

  def todo_list_project(todo_list)
    @projects ||= Basecamp.new(current_token).projects

    bcx_id = todo_list.url.match(/\/projects\/(\d+)/).captures.first.to_i
    @projects.find { |p| p.id == bcx_id }
  end
end
