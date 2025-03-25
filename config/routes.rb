Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  # Core resources
  resources :items
  resources :customers do
    resources :addresses
  end
  resources :sales_orders
  resources :purchase_orders

  # Financial Accounting
  resources :accounts do
    collection do
      get :balance_sheet
      get :income_statement
      get :cash_flow
      get :ebitda
    end
    resources :transactions
  end

  resources :transactions

  # Admin namespace
  namespace :admin do
    root to: 'admin#index'
    
    # Item Management
    resources :item_types
    resources :item_subtypes
    resources :product_keys
    resources :commodity_keys
    resources :abc_keys
    resources :eccn_keys
    
    # Order Management
    resources :order_methods
    resources :price_groups
    
    # Inventory Management
    resources :track_serial_lots
    resources :auto_lot_issue_methods
    resources :storage_conditions
    
    # Address Management
    resources :addresses do
      collection do
        get :addressable_options
      end
    end
  end

  # Vendor and Supplier resources
  resources :vendors do
    resources :addresses
  end

  resources :suppliers do
    resources :addresses
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
