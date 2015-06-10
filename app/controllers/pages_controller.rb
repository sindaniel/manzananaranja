class PagesController < ApplicationController
  protect_from_forgery except: :agregarmenudia

  def index
  end


  def micuenta

  end

  def armarmenu

  end


  def getMenus
    @menus = Menucliente.find_by_sql(' SELECT C.estado, M.created_at, M.date, C.date AS fechacliente FROM `menuclientes` C LEFT JOIN menus M USING (date)')

    render json: @menus
  end


  def armarmenudia
    @ingredientes = Menu.find_by_date(params[:fecha])
    render layout: 'menu'
  end


  def agregarmenudia

    @menuCliente = Menucliente.find_by_date(params[:fecha])
    #falta poner el usuario
    @menuCliente.update_attributes(:estado=>1, :protein_id => params[:proteina], :soup_id => params[:sopa], :carbohydrate_id=> params[:carbo], :salad_id => params[:ensalada],:wok_id =>params[:wok])
    render layout: false
  end



  def quehacemos


  end


  def planes

  end

  def estilodevida

  end



  def comofunciona

  end

  def promesadeservicio

  end

  def preguntasfrecuentes

  end

  def informenutricional

  end


  def simulador

  end

  def contacto

  end


  def micuentaeditar

  end


  def miplan


  end


end
