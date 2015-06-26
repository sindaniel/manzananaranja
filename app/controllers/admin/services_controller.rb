class Admin::ServicesController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index

    @plans = Service.all
  end

  def new
    @plan = Service.new
  end

  def create


    @plan = Service.new(allowed_params)
    if @plan.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_services_path
    else
      render 'new'
    end



  end

  def edit
    @plan = Service.find(params[:id])
  end

  def update

    @plan = Service.find(params[:id])

    if @plan.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_services_path
    else
      render 'new'
    end


  end






  private
  def allowed_params
    params.require(:service).permit!
  end
end
