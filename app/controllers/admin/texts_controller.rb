class Admin::TextsController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index

    @texts = Text.where('category = '+params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @text = Text.find(params[:id])
  end

  def update


    @text = Text.find(params[:id])

    if @text.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_texts_path(:id=>@text.category)
    else
      render 'new'
    end


  end

  private
  def allowed_params
    params.require(:text).permit!
  end

end
