require 'basecamp'

namespace :migrate do
  desc "Migrate time entries"
  task :time_entries => :environment do
    bcx = Basecamp.new(ENV['TOKEN'])
    projects = bcx.projects.map do |bcx_hash|
      Project.find_or_create_by_bcx_hash(bcx_hash)
    end

    TimeEntry.all.each do |time_entry|
      todo_id = time_entry.todo_id
      bcx_hash = nil
      projects.each do |project|
        bcx_hash = bcx.todo(project.bcx_id, todo_id)
        if bcx_hash.is_a?(Hashie::Mash)
          todo = Todo.find_or_create_by_bcx_hash(bcx_hash) do |todo|
            todo.project = project
          end

          title = time_entry.title.gsub(/\A.*?\s\|\s/, '')
          time_entry.update_attributes(project_id: project.id, todo: todo, title: title)

          break
        else
          bcx_hash = nil
        end
      end

      unless bcx_hash
        time_entry.update_attributes(todo_id: nil, bcx_todo_id: time_entry.todo_id)
      end
    end
  end
end
