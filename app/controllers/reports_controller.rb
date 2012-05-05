class ReportsController < ApplicationController
  def show
    @time_entries = TimeEntry.created_between(params[:created_at_gte], params[:created_at_lte]).where(:project_id.exists => true).includes(:todo, :project)
  end
end
