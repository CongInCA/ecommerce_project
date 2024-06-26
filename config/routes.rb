Rails.application.routes.draw do
  get 'home/index'
  #devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end
  devise_for :users, controllers: { registrations: 'registrations' }

    ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  resources :orders, only: [:index]

  root "products#index"

  post 'add_to_cart', to: 'carts#add_to_cart'
  post 'place_order', to: 'carts#place_order'

  patch 'update_cart', to: 'carts#update_cart'
  delete 'remove_from_cart', to: 'carts#remove_from_cart'
  patch 'update_address', to: 'users#update_address'

  resources :carts do
    get 'checkout', on: :collection 
  end

  namespace :admin do
    resources :customer_orders, only: [:index]
  end
end
