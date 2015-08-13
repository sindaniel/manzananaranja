class Admin::MenuclientesController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'

  def index



    @menusNombreCliente  = Menucliente.find_by_sql('SELECT * FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id WHERE M.estado=1 AND  M.date = "2015-08-20"')



    if params[:date].nil?





    else
     @menusNombreCliente  = Menucliente.find_by_sql('SELECT * FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id WHERE M.estado=1 AND  M.date = "'+params[:date]+'"')


     @proteinas =     Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN proteins P ON M.protein_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY protein_id')
     @woks =          Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN woks P ON M.wok_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY wok_id')
     @sopas =         Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN soups P ON M.soup_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY soup_id')
     @ensaladas =     Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN salads P ON M.salad_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY salad_id')
     @carbohidratos = Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN carbohydrates P ON M.carbohydrate_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY carbohydrate_id')
    end







  end



def menudiacsv


  @menusNombreCliente  = Menucliente.find_by_sql('SELECT * FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id WHERE M.estado=1 AND  M.date = "'+params[:date]+'"')


  @proteinas =     Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN proteins P ON M.protein_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY protein_id')
  @woks =          Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN woks P ON M.wok_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY wok_id')
  @sopas =         Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN soups P ON M.soup_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY soup_id')
  @ensaladas =     Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN salads P ON M.salad_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY salad_id')
  @carbohidratos = Menucliente.find_by_sql('SELECT P.name, count(*) as "total" FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id INNER JOIN carbohydrates P ON M.carbohydrate_id = P.id WHERE M.estado=1 AND M.date = "'+params[:date]+'  " GROUP BY carbohydrate_id')




  respond_to do |format|
    format.csv do
      headers['Content-Disposition'] = "attachment; filename=\"user-list.csv\""
      headers['Content-Type'] ||= 'text/csv'
    end
  end


end


end