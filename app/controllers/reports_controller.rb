class ReportsController < ApplicationController
  def show
    @time_entries = TimeEntry.where(:project_id.exists => true)
  end
end
