Rails.application.routes.draw do



  devise_for :users


  root 'pages#index', as: 'home'
  get 'mi-cuenta.html' => 'pages#micuenta', as: 'micuenta'
  post 'mi-cuenta.html' => 'pages#micuenta', as: 'micuentapost'
  get 'mi-cuenta-armar-menu-mes.html' => 'pages#armarmenu', as: 'armememu'
  get 'mi-cuenta-menu-del-dia.html' => 'pages#armarmenudia', as: 'menudia'

  get 'que-hacemos.html' => 'pages#quehacemos', as: 'quehacemos'
  get 'planes.html' => 'pages#planes', as: 'planes'
  get 'estilo-de-vida.html' => 'pages#estilodevida', as: 'estilodevida'





  get 'como-funciona.html' => 'pages#comofunciona', as: 'comofunciona'
  get 'promesa-de-servicio.html' => 'pages#promesadeservicio', as: 'promesadeservicio'
  get 'preguntas-frecuentes.html' => 'pages#preguntasfrecuentes', as: 'preguntasfrecuentes'
  get 'informe-nutricional.html' => 'pages#informenutricional', as: 'informenutricional'
  get 'simulador-ahorro.html' => 'pages#simulador', as: 'simulador'
  get 'contacto.html' => 'pages#contacto', as: 'contacto'
  post 'contacto.html' => 'pages#contacto', as: 'contactopost'
  get 'mi-cuenta-editar-datos.html' => 'pages#micuentaeditar', as: 'micuentaeditar'
  post 'mi-cuenta-editar-datos.html' => 'pages#micuentaeditarpost', as: 'micuentaeditarpost'
  get 'mi-plan.html' => 'pages#miplan', as: 'miplan'
  get 'mi-cuenta-comprar.html' => 'pages#comprar', as: 'comprar'



  get 'saveUser' => 'pages#saveUser', as: 'saveUser'
  get 'salir' => 'pages#salir', as: 'salir'



  get 'festivos' => 'pages#getFestivos', as: 'getfestivos'
  get 'platosdisponibles' => 'pages#platosdisponibles', as: 'platosdisponibles'


  post 'agregarmenudia' => 'pages#agregarmenudia', as: 'agregarmenudia'




  get 'getmenus' => 'pages#getMenus', as: 'getmenus'

  get 'getmenusmes', to: 'customers#getmenus', as: 'getmenusmes'

  get 'getdaydisponible', to: 'pages#getdaydisponible', as: 'getdaydisponible'


  namespace :admin do
    get 'menus/index'
  end
  namespace :admin do
    get '', to: 'menus#index', as: '/'


    get 'menudiacsv', to: 'menuclientes#menudiacsv', as: 'menudiacsv'
    get 'searchcustomer', to: 'customers#searchcustomer', as: 'searchcustomer'
    get 'viewcustomer', to: 'customers#viewcustomer', as: 'viewcustomer'




    resources :soups,
              :woks,
              :proteins,
              :carbohydrates,
              :salads,
              :menus,
              :menuclientes,
              :services,
              :planclientes,
              :texts,
              :customers,
        :pictures

  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
