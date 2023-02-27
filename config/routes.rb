Rails.application.routes.draw do
  get 'tables/index'
  get 'tables/show'
  get 'dashboard/index'
  mount ActionCable.server, at: '/cable'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  devise_scope :user do
    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
    end
  end

  root to: 'home#index'
  get '/settings', to: 'settings#index', as: :settings
  put '/settings', to: 'settings#update'

  resources :menus
  get '/sync/:id', to: 'menus#sync', as: :sync
  get '/qr_code/:id', to: 'menus#qr_code', as: :qr_code

  resources :tables, only: [:index, :show]

  resources :cart
  post 'cart/add', to: 'cart#add', as: :cart_add
  post 'cart/remove', to: 'cart#remove', as: :cart_remove
  post '/checkout', to: 'cart#checkout', as: :checkout
  post '/billed', to: 'cart#billed', as: :billed

  resources :orders, only: [:index, :show]
  post 'orders/served', to: 'orders#served', as: :served
  post 'orders/process', to: 'orders#processing', as: :processing
  post 'orders/cancel', to: 'orders#cancel', as: :item_cancel
end
