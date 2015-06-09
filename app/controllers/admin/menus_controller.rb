class Admin::MenusController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index
    @menus = Menu.all
  end

  def new




    @menu = Menu.new
    @menu.date = Menu.last.date + 1.day
  end

  def create
    @menu = Menu.new(allowed_params)
    if @menu.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_menus_path
    else
      render 'new'
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end



  def update

    @menu = Menu.find(params[:id])

    if @menu.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_menus_path
    else
      render 'new'
    end


  end


  private
  def allowed_params
    params.require(:menu).permit!
  end
end
