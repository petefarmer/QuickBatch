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
  resources :abc_keys

  namespace :admin do
    root to: 'admin#index'
    get "price_groups/index"
    get "price_groups/show"
    get "price_groups/new"
    get "price_groups/edit"
    get "price_groups/create"
    get "price_groups/update"
    get "price_groups/destroy"
    get "order_methods/index"
    get "order_methods/new"
    get "order_methods/create"
    get "order_methods/edit"
    get "order_methods/update"
    get "order_methods/destroy"
    resources :item_types
    resources :item_subtypes
    resources :order_methods
    resources :price_groups
    resources :product_keys
    resources :commodity_keys
    resources :abc_keys
    resources :eccn_keys
    resources :track_serial_lots
    resources :auto_lot_issue_methods
    resources :storage_conditions
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
