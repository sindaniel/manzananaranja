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
      @user = Customers.find_by_id(session[:login])
      @armar = true;



      if @user.plancliente.last.service_id == 5

        @plan = Service.find_by_id(5)


        creado = @user.plancliente.last.created_at.to_s

        @limite = @user.plancliente.last.created_at + @plan.limite.days


        @menusHechos  = Menucliente.find_by_sql('SELECT * FROM `menuclientes` M INNER JOIN customers C ON M.usuario_id = C.id WHERE M.estado=1 AND M.date >= "'+creado+'"   AND M.date<="'+@limite.to_s+'" AND  M.usuario_id = "'+session[:login].to_s+'"')



        if @menusHechos.count >= @plan.dishes
          @armar = false
        end


      end






      @menuscliente = Menucliente.where('usuario_id= ?', session[:login])

    end

  end


  def getMenus




    user = Customers.find_by_id(session[:login])

    #valido si tiene tiquetera
    if user.plancliente.last.service_id == 5


      fechaDisponible = user.plancliente.last.updated_at
      disponible = fechaDisponible.strftime("%w").to_i
      validoHora = true
      if disponible == 0
        fechaDisponible  = fechaDisponible + 1.days
        validoHora = false
      end

      if disponible == 6
        fechaDisponible  = fechaDisponible + 2.days
        validoHora = false
      end


      if validoHora

        horaDeCompra = fechaDisponible.strftime("%H").to_i
        if horaDeCompra > 10
          fechaDisponible  = fechaDisponible + 1.days
        end

      end


      fechaactual =  DateTime.now.strftime("%Y-%m-%d");
      fechaactual = fechaactual.to_date + 1.days


     # @menus = Menucliente.find_by_sql('SELECT  M.date AS "fechacliente", MC.estado, MC.wok_id, M.date FROM `menus` M LEFT JOIN menuwoks W ON W.menu_id = M.id LEFT JOIN menuclientes MC ON MC.date = M.date  WHERE M.date > "'+fechaactual.to_s+'"   GROUP BY M.date ORDER BY M.date ASC')
    #  @menus = Menucliente.find_by_sql(' SELECT C.estado, M.created_at, M.date, C.date AS fechacliente, W.wok_id FROM `menuclientes` C LEFT JOIN menus M USING (date) LEFT JOIN menuwoks W ON W.menu_id = M.id   WHERE C.usuario_id='+session[:login].to_s)

    @menus = Menucliente.find_by_sql('SELECT M.date AS "fechacliente", MC.estado, MC.wok_id, M.date FROM `menus` M LEFT JOIN menuwoks W ON W.menu_id = M.id INNER JOIN menuclientes MC ON MC.date = M.date INNER JOIN customers C ON MC.usuario_id = C.id WHERE M.date > "'+fechaactual.to_s+'" AND C.id = '+session[:login].to_s+' AND MC.wok_id IS NOT NULL  GROUP BY W.menu_id ORDER BY M.date ASC')

      render json: @menus
    else

      @menus = Menucliente.find_by_sql(' SELECT C.estado, M.created_at, M.date, C.date AS fechacliente, W.wok_id FROM `menuclientes` C LEFT JOIN menus M USING (date) LEFT JOIN menuwoks W ON W.menu_id = M.id   WHERE C.usuario_id='+session[:login].to_s)
      render json: @menus



    end






  end





  def platosdisponibles

    fechaactual =  DateTime.now.strftime("%Y-%m-%d");
    fechaactual = fechaactual.to_date + 1.days

    @menus = Menucliente.find_by_sql(' SELECT C.estado, M.created_at, M.date, C.date AS fechacliente, W.wok_id FROM `menuclientes` C LEFT JOIN menus M USING (date) LEFT JOIN menuwoks W ON W.menu_id = M.id ')
    @menucreados = Menu.find_by_sql('SELECT M.id, M.date, M.estado FROM `menus` M  INNER JOIN menuwoks W ON M.id = W.menu_id where date> "'+fechaactual.to_s+'" GROUP BY M.id ORDER BY DATE')
    render json: @menucreados


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



      @user = Customers.find_by_id(session[:login])
      @user.plancliente.last.service_id


      if @user.plancliente.last.service_id == 5
        @valido =  Menucliente.where('date= ? and usuario_id=? and estado=1', params[:fecha], session[:login])

        render 'armarmenudia4', layout: 'menu'
      else



        @valido =  Menucliente.where('date= ? and usuario_id=?', params[:fecha], session[:login])

        if !@valido.exists?
          redirect_to armememu_path
        else
          render  layout: 'menu'
        end



      end







    end



  end


  def agregarmenudia


    @user = Customers.find_by_id(session[:login])
    @user.plancliente.last.service_id


    if @user.plancliente.last.service_id == 5

        if  params[:agregar]


          o = Menucliente.new(:estado=>1, :protein_id => params[:proteina], :soup_id => params[:sopa], :carbohydrate_id=> params[:carbo], :salad_id => params[:ensalada],:wok_id =>params[:wok], :date=>params[:fecha], :usuario_id=> session[:login])
          o.save

        else



          @menuClienteId = Menucliente.where('date= ? and usuario_id=?', params[:fecha], session[:login]).limit(1)


          @menuCliente = Menucliente.find_by_id(@menuClienteId[0].id)

          #falta poner el usuario
          @menuCliente.update_attributes(:estado=>1, :protein_id => params[:proteina], :soup_id => params[:sopa], :carbohydrate_id=> params[:carbo], :salad_id => params[:ensalada],:wok_id =>params[:wok])
          render layout: false




        end


    else



      @menuClienteId = Menucliente.where('date= ? and usuario_id=?', params[:fecha], session[:login]).limit(1)


      @menuCliente = Menucliente.find_by_id(@menuClienteId[0].id)

      #falta poner el usuario
      @menuCliente.update_attributes(:estado=>1, :protein_id => params[:proteina], :soup_id => params[:sopa], :carbohydrate_id=> params[:carbo], :salad_id => params[:ensalada],:wok_id =>params[:wok])
      render layout: false




    end


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
          :sex => params[:sex],
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


          @planComprado = Service.find_by_id(params[:plan])
          puts "http://webdaniel.info/mailmanzana/pago.php?nombre="+Rack::Utils.escape(params[:firstname])+"&email="+Rack::Utils.escape(params[:email])+"&platos="+Rack::Utils.escape(@planComprado.dishes)+"&vence="+Rack::Utils.escape(@disponibles[i].date)

          open("http://webdaniel.info/mailmanzana/pago.php?nombre="+Rack::Utils.escape(params[:firstname])+"&email="+Rack::Utils.escape(params[:email])+"&platos="+Rack::Utils.escape(@planComprado.dishes)+"&vence="+Rack::Utils.escape(@disponibles[i].date))
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

    #Mailer.contact().deliver
    @mensaje = false
    if request.post?

      open("http://webdaniel.info/mailmanzana/contacto.php?tipo="+Rack::Utils.escape(params[:tipo])+"&nombres="+Rack::Utils.escape(params[:nombre])+"&email="+Rack::Utils.escape(params[:email])+"&telefono="+Rack::Utils.escape(params[:telefono])+"&mensaje="+Rack::Utils.escape(params[:mensaje]))


      @mensaje = true
    end

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


  def salir
    session[:login] = nil
    redirect_to home_path
  end

end
