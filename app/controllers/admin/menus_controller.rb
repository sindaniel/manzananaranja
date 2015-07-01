class Admin::MenusController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'


  def index
    @menus = Menu.all

    if !params[:date].nil?
      @menu = Menu.where(:date=>params[:date])

      if !@menu.blank?

        redirect_to edit_admin_menu_path(@menu[0].id,)
      else

        redirect_to admin_menus_path(:nada=>1, :date1=>params[:date])
      end
    end
    fechaactual =  DateTime.now.strftime("%Y-%m-%d");



    limite = 5

    if params[:page].nil?
      inicio = 0
      pagina = 1
    else
      pagina = params[:page].to_i
      inicio = (pagina - 1) * limite
    end




    @cuentaregistros = Menu.find_by_sql('SELECT M.id, M.date, M.estado FROM `menus` M  INNER JOIN menuwoks W ON M.id = W.menu_id  where date>= "'+fechaactual.to_s+'"  GROUP BY M.id ORDER BY DATE ')


    @totalpaginas = @cuentaregistros.count / limite.to_f



    @menucreados = Menu.find_by_sql('SELECT M.id, M.date, M.estado FROM `menus` M  INNER JOIN menuwoks W ON M.id = W.menu_id where date>= "'+fechaactual.to_s+'" GROUP BY M.id ORDER BY DATE LIMIT '+inicio.to_s+','+limite.to_s)








    #@menucreados = Menu.all.where('estado = 0 and date>= "'+fechaactual.to_s+'"').order('DATE ASC')
  end

  def new




    @menu = Menu.new


    siguienteDia =  Menu.last.date + 1.day


    #valido que no sea sabado 6 o domingo 7
    siguienteDiaNumero =  siguienteDia.strftime("%w")

    puts siguienteDiaNumero


    if siguienteDiaNumero == '6'
      @menu.date = Menu.last.date + 3.day

    elsif siguienteDiaNumero == 7
      @menu.date = Menu.last.date + 2.day
    else
      @menu.date = Menu.last.date + 1.day
    end







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
