Rails.application.routes.draw do
  
  use_doorkeeper
  root 'pages#home'
  get '/home', to: 'pages#home'
  
  # get '/thermostats', to: 'thermostats#index'
  # get '/thermostats/new', to: 'thermostats#new', as: 'new_thermostat'
  # post '/thermostats', to: 'thermostats#create'
  # get '/thermostats/:id/edit', to: 'thermostats#edit', as: 'edit_thermostat'
  # patch '/thermostats/:id', to: 'thermostats#update'
  # get 'thermostats/:id', to: 'thermostats#show', as: 'thermostat'
  # delete '/thermostats/:id', to: 'thermostats#destroy'
  
  resources :thermostats
  resources :makers, except: [:new] 
  
  get 'thermostats/:id/temp', to: 'thermostats#temp'
  
  get '/login', to: "logins#new"
  post '/login', to: "logins#create"
  get '/logout', to: "logins#destroy"
  
  get '/register', to: 'makers#new'
  

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
