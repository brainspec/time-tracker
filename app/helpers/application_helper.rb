module ApplicationHelper
  def basecamp_url(obj)
    url = obj.respond_to?(:url) ? obj.url : obj.to_s
    url.gsub(/\.json$/, '').gsub('/api/v1', '')
  end

  def todo_list_project(todo_list)
    bcx_id = todo_list.url.match(/\/projects\/(\d+)/).captures.first.to_i

    Project.where(bcx_id: bcx_id).first || begin
      matched_project = nil

      Basecamp.new(current_token).projects.each do |bcx_hash|
        project = Project.find_or_create_by_bcx_hash(bcx_hash)
        matched_project = project if project.bcx_id == bcx_id
      end

      matched_project
    end
  end

  def navigation_item(name, url)
    link = content_tag(:a, name, href: url)
    content_tag(:li, link, class: request.url == url ? 'active' : '')
  end

  def basecamp_project_url(project)
    "https://basecamp.com/#{ENV['ACCOUNT_ID']}/projects/#{project.bcx_id}"
  end

  def basecamp_todo_url(todo)
    "#{basecamp_project_url(todo.project)}/todos/#{todo.bcx_id}"
  end
end
