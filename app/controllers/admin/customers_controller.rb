class Admin::CustomersController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index


  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def  searchcustomer
    @customers = Customers.select('email').where(' `email` LIKE "%'+params[:q]+'%" ' )
    render json: @customers
  end

  def  viewcustomer
    @customer = Customers.find_by_email(params[:email])

    @menusGeneral  = Menucliente.find_by_sql('SELECT * FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id WHERE  M.usuario_id = "'+@customer.id.to_s+'" ORDER BY date ASC')
    @menusHechos  = Menucliente.find_by_sql('SELECT * FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id WHERE M.estado=1 AND  M.usuario_id = "'+@customer.id.to_s+'"')

    @menusPorHacer  = Menucliente.find_by_sql('SELECT * FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id WHERE M.estado=0 AND  M.usuario_id = "'+@customer.id.to_s+'"')

  end
end
