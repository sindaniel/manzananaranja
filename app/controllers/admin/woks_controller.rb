class Admin::WoksController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'

  def index

    @woks = Wok.all


  end

  def new
    @wok = Wok.new
  end

  def create

    @wok = Wok.new(allowed_params)
    if @wok.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_woks_path
    else
      render 'new'
    end



  end

  def edit
    @wok = Wok.find(params[:id])
  end

  def update

    @wok = Wok.find(params[:id])

    if @wok.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_woks_path
    else
      render 'new'
    end


  end

  def destroy
    @wok = Wok.find(params[:id])
    if @wok.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_woks_path
    else
      render 'new'
    end



  end


  private
  def allowed_params
    params.require(:wok).permit!
  end

end
