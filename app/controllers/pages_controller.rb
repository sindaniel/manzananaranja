class PagesController < ApplicationController
  protect_from_forgery except: :agregarmenudia



  def index







  end


  def micuenta




    if session[:login].nil?


      @message = false

      if request.post?
        @usuario = Customers.where('email = ? and password = ?', params[:email], params[:clave])

        if @usuario.count == 0
          @message = true
        else
          session[:login] = @usuario[0].id
          redirect_to armememu_path

        end

      end


    else
      redirect_to armememu_path
    end


  end


  def armarmenu

    if session[:login].nil?
      redirect_to home_path
    else

      @plancliente = Plancliente.find_by_customers_id(session[:login])

      @menuscliente = Menucliente.where('usuario_id= ?', session[:login])




    end

  end


  def getMenus
    @menus = Menucliente.find_by_sql(' SELECT C.estado, M.created_at, M.date, C.date AS fechacliente FROM `menuclientes` C LEFT JOIN menus M USING (date) WHERE C.usuario_id='+params[:user])
    render json: @menus
  end


  def  getdaydisponible
    @menus = Menucliente.find_by_sql('SELECT * FROM `menus` WHERE date>= "'+params[:from]+'" and date <= "'+params[:to]+'" ')
    render json: @menus
  end

  def getFestivos
    @festivos = Menu.where(:estado=>1)
    render json: @festivos
  end


  def armarmenudia



    if session[:login].nil?
      redirect_to home_path
    else
      @pictures = Picture.all
      @ingredientes = Menu.find_by_date(params[:fecha])

      #valido dia
     @valido =  Menucliente.where('date= ? and usuario_id=?', params[:fecha], session[:login])

      if !@valido.exists?
        redirect_to armememu_path
      else
        render layout: 'menu'
      end




    end



  end


  def agregarmenudia

    @menuClienteId = Menucliente.where('date= ? and usuario_id=?', params[:fecha], session[:login]).limit(1)


    @menuCliente = Menucliente.find_by_id(@menuClienteId[0].id)

    #falta poner el usuario
     @menuCliente.update_attributes(:estado=>1, :protein_id => params[:proteina], :soup_id => params[:sopa], :carbohydrate_id=> params[:carbo], :salad_id => params[:ensalada],:wok_id =>params[:wok])
    render layout: false
  end



  def quehacemos
    @textsGenerals  = Text.all

  end


  def planes
    @textsGenerals  = Text.all
    @plans = Service.all




  end


  def comprar
    if params[:plan].nil?
      redirect_to planes_path
    else
      @plan = Service.find_by_id(params[:plan])
    end


    o = [(0..9), ('A'..'Z')].map { |i| i.to_a }.flatten
    @referencia = (0...10).map { o[rand(o.length)] }.join

    
  end


  def saveUser


    if Customers.find_by_email(params[:email])
      data = [:estado => 'si']
    else
      data = [:estado => 'no']

      o = Customers.new(
          :lastname => params[:lastname],
          :firstname => params[:firstname],
          :phone => params[:phone],
          :email => params[:email],
          :password => params[:password],
          :address => params[:address],
          :sex => 1,
      )
      if o.save

        plancliente = Plancliente.new

        plancliente.customers_id = o.id
        plancliente.service_id = params[:plan]
        plancliente.name = params[:referencia]

        if plancliente.save
          data = [:guardoplan => 'si']
        end




        @horaActual =  Time.new


        if @horaActual.strftime("%H").to_i>=11
          @diaSegunHora = 2
        else
          @diaSegunHora = 1
        end


        @diaInicio =  Date.today

        siguienteDia =  @diaInicio + @diaSegunHora.day

        #valido que no sea sabado 6 o domingo 7
        siguienteDiaNumero =  siguienteDia.strftime("%w")

        puts siguienteDiaNumero
        if siguienteDiaNumero == '6'
          @diaInicio = @diaInicio + 3.day

        elsif siguienteDiaNumero == 7
          @diaInicio = @diaInicio + 2.day
        else
          @diaInicio = @diaInicio + @diaSegunHora.day
        end


        @disponibles = Menu.where('date >= ?', @diaInicio)


        #dias que compro
        @diasDelPlan = Service.find_by_id(params[:plan])

        i = 0
        dias = @diasDelPlan.dishes
        diaAgregado = 0

        insertar = true

        while  insertar do

          if  @disponibles[i].estado == false


            puts @disponibles[i].date


            menu = Menucliente.new
            menu.date  = @disponibles[i].date
            menu.estado = 0
            menu.usuario_id = o.id
            menu.save

            diaAgregado += 1
          end

          i +=1


          if dias == diaAgregado
            insertar = false
          end
        end




        session[:login] = o.id


      end



    end


    render json: data

    # render layout: false
  end


  def estilodevida
    @textsGenerals  = Text.all
  end



  def comofunciona

  end

  def promesadeservicio
    @textsGenerals  = Text.where('category =4')

  end

  def preguntasfrecuentes
    @textsGenerals  = Text.where('category =5')

  end

  def informenutricional

    render :action => 'informenutricional', :layout => 'layouts/applicationangular'


  end


  def simulador

  end

  def contacto

  end


  def micuentaeditar

    if session[:login].nil?
      redirect_to home_path
    else


    @cliente = Customers.find_by_id(session[:login])
    end


  end


  def micuentaeditarpost

    @cliente = Customers.find_by_id(session[:login])



    #falta poner el usuario
    @cliente.update_attributes(:email => params[:email], :firstname => params[:firstname], :phone=> params[:phone], :sex => params[:sex])


    if(params[:clave] != '')
        @cliente.update_attributes( :password => params[:clave])
    end



    redirect_to(micuentaeditar_path)


  end


  def miplan


  end


end
