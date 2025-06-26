class DashboardsController < ApplicationController
  before_action :authenticate_admin_user!

  def show
    @installations = Installation.includes(:technician).order(starts_at: :desc)
    @daily_installations = Installation.group_by_day(:starts_at).count
    @daily_technicians = Installation.group_by_day(:starts_at).distinct.count(:technician_id)
  end
end