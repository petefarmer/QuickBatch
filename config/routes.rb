Rails.application.routes.draw do
  get "admin/index"
  get "sales_orders/index"
  get "sales_orders/show"
  get "sales_orders/new"
  get "sales_orders/edit"
  get "sales_orders/create"
  get "sales_orders/update"
  get "sales_orders/destroy"
  get "customers/index"
  get "customers/show"
  get "customers/new"
  get "customers/edit"
  get "customers/create"
  get "customers/update"
  get "customers/destroy"
  root "items#index"
  resources :items
  resources :item_types
  resources :customers
  resources :sales_orders
  resources :purchase_orders

  namespace :admin do
    get 'index'
    resources :item_types
    resources :item_subtypes
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
