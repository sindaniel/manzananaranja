class Admin::PicturesController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index
    @pictures = Picture.all
  end

  def new
  end

  def create
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update

    @picture = Picture.find(params[:id])

    if @picture.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_pictures_path
    else
      render 'new'
    end



  end

  def destroy
  end


  private
  def allowed_params

    params.require(:picture).permit!
  end

end
