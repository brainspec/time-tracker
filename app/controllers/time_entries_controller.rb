class TimeEntriesController < ApplicationController
  respond_to :js

  def create
    @time_entry = current_user.time_entries.new(time_entry_params)
    @time_entry.save
  end

  def destroy
    @time_entry = current_user.time_entries.find(params[:id])
    @time_entry.destroy
    render nothing: true
  end

  private

  def time_entry_params
    params[:time_entry].slice(:todo_id, :hours, :comment)
  end
end
