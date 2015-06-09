class Admin::ProteinsController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'

  def index
    @proteins = Protein.all
  end

  def new
    @protein = Protein.new
  end

  def create

    @protein = Protein.new(allowed_params)
    if @protein.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_proteins_path
    else
      render 'new'
    end

  end

  def edit
    @protein = Protein.find(params[:id])
  end

  def update

    @protein = Protein.find(params[:id])

    if @protein.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_proteins_path
    else
      render 'new'
    end


  end

  def destroy
    @protein = Protein.find(params[:id])
    if @protein.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_proteins_path
    else
      render 'new'
    end

  end


  private
  def allowed_params
    params.require(:protein).permit!
  end
end
