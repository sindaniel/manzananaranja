class Admin::SaladsController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index
    @salads = Salad.all
  end

  def new
    @salad = Salad.new
  end

  def create

    @salad = Salad.new(allowed_params)
    if @salad.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_salads_path
    else
      render 'new'
    end

  end

  def edit
    @salad = Salad.find(params[:id])
  end

  def update

    @salad = Salad.find(params[:id])

    if @salad.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_salads_path
    else
      render 'new'
    end


  end

  def destroy
    @salad = Salad.find(params[:id])
    if @salad.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_salads_path
    else
      render 'new'
    end

  end


  private
  def allowed_params
    params.require(:salad).permit!
  end

end
