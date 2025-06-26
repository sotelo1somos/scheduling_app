class InstallationsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  def index
    @installations = Installation.includes(:technician).order(starts_at: :desc)
  end

  def show
  end

  def new
    @installation = Installation.new
    @technicians = Technician.all
  end

  def create
    @installation = Installation.new(installation_params)
    if @installation.save
      redirect_to dashboard_path, notice: "Instalación creada exitosamente."
    else
      @technicians = Technician.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @technicians = Technician.all
  end 

  def update
    if @installation.update(installation_params)
      redirect_to dashboard_path, notice: "Instalación actualizada."
    else
      @technicians = Technician.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @installation.destroy
    redirect_to installations_path, notice: "Instalación eliminada."
  end

  private

  def set_installation
    @installation = Installation.find(params[:id])
  end

  def installation_params
    params.require(:installation).permit(:customer_name, :address, :starts_at, :ends_at, :technician_id)
  end
end