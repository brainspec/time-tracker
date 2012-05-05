require 'basecamp'

class TimeEntriesController < ApplicationController
  respond_to :js

  def index
    @time_entries = current_user.time_entries.this_day
  end

  def create
    @time_entry = current_user.time_entries.new(time_entry_params)
    @time_entry.project = project
    @time_entry.todo    = todo
    @time_entry.save
  end

  def destroy
    @time_entry = current_user.time_entries.this_day.find(params[:id])
    @time_entry.destroy
    @time_entries = current_user.time_entries.this_day
  end

  private

  def time_entry_params
    params[:time_entry].slice(:hours, :comment, :title)
  end

  def project
    @project ||= begin
      hash = Basecamp.new(current_token).project(params[:time_entry][:project_id])
      Project.find_or_create_by_bcx_hash(hash)
    end
  end

  def todo
    @todo ||= begin
      hash = Basecamp.new(current_token).todo(*params[:time_entry].slice(:project_id, :todo_id).values)
      Todo.find_or_create_by_bcx_hash(hash) do |todo|
        todo.project = project
      end
    end
  end
end
