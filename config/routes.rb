Rails.application.routes.draw do

  root to: "app#index"
  get "/index", to: "app#index", as: "index"
  get "/checkout", to: "orders#checkout", as: "checkout"
  post "/signup", to: "users#create", as: "signup"
  post "/signin", to: "sessions#create", as: "signin"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "searches#index"

  resources :users
  resources :products, only: [:index, :show]
  resource :carts, only: [:show, :destroy]
  resources :order_items, only: [:create, :update, :destroy]
  resources :categories, only: :show
  resources :orders, only: :index

  namespace :admin do
    root to: "admin#index"
    resources :products, except: :show
    resources :providers, only: :create
    resources :categories, only: :create
    resources :orders, only: :index
  end
end
