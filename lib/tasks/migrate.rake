require 'basecamp'

namespace :migrate do
  desc "Migrate time entries"
  task :time_entries => :environment do
    basecamp = Basecamp.new(ENV['TOKEN'])
    project_ids = basecamp.projects.map(&:id)
    TimeEntry.all.each do |time_entry|
      todo_id = time_entry.todo_id
      bcx_hash = nil
      project_ids.each do |project_id|
        bcx_hash = basecamp.todo(project_id, todo_id)
        if bcx_hash.is_a?(Hashie::Mash)
          break
        else
          bcx_hash = nil
        end
      end

      if bcx_hash
        todo  = Todo.find_or_create_by_bcx_hash(bcx_hash)
        title = time_entry.title.gsub(/\A.*?\s\|\s/, '')
        time_entry.update_attributes(todo_id: todo.id, bcx_todo_id: bcx_hash.id, title: title)
      else
        time_entry.update_attributes(todo_id: nil, bcx_todo_id: time_entry.todo_id)
      end
    end
  end
end