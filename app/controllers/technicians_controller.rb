class TechniciansController < ApplicationController
  def index
  end

  def show
  end

  def timetable
  @technician = Technician.find(params[:id])
  @installations = @technician.installations.where(starts_at: Time.zone.today.all_day).order(:starts_at)
  end
end

