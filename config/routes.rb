Cartoque::Application.routes.draw do
  # Authentication routes
  devise_for :users

  # API
  namespace :api, defaults: { format: 'json' } do
    resources :contacts
    resources :apps
    resources :servers
    resources :users do
      collection { get :random_token, as: :random_token }
    end
    resources :locations
    get "history", to: "history#index", as: "history"
    #hook for generators
    root 'root#index'
    #catch-all route to avoid ActionController#RoutingError's
    match '*a', to: 'application#render_404', via: :all
  end

  # Webapp
  resources :contacts
  resources :apps
  resources :servers
  resources :users
  resources :locations
  get "help/:page", to: "help#show", as: "help"
  get "welcome/index"

  # Default root
  root 'welcome#index'

  # Catch-all route to avoid ActionController#RoutingError's
  match '*a', to: 'application#render_404', via: :all

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
