class Admin::SoupsController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index
    @soups = Soup.all
  end

  def new
    @soup = Soup.new
  end

  def create

    @soup = Soup.new(allowed_params)
    if @soup.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_soups_path
    else
      render 'new'
    end

  end

  def edit
    @soup = Soup.find(params[:id])
  end

  def update

    @soup = Soup.find(params[:id])

    if @soup.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_soups_path
    else
      render 'new'
    end


  end

  def destroy
    @soup = Soup.find(params[:id])
    if @soup.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_soups_path
    else
      render 'new'
    end

  end


  private
  def allowed_params
    params.require(:soup).permit!
  end

end
