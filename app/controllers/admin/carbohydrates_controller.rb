class Admin::CarbohydratesController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index
    @carbohydrates = Carbohydrate.all
  end

  def new
    @carbohydrate = Carbohydrate.new
  end

  def create

    @carbohydrates = Carbohydrate.new(allowed_params)
    if @carbohydrates.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_carbohydrates_path
    else
      render 'new'
    end

  end

  def edit
    @carbohydrate = Carbohydrate.find(params[:id])
  end

  def update

    @carbohydrates = Carbohydrate.find(params[:id])

    if @carbohydrates.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_carbohydrates_path
    else
      render 'new'
    end


  end

  def destroy
    @carbohydrates = Carbohydrate.find(params[:id])
    if @carbohydrates.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_carbohydrates_path
    else
      render 'new'
    end

  end


  private
  def allowed_params
    params.require(:carbohydrate).permit!
  end

end
