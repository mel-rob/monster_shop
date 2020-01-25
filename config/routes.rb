Rails.application.routes.draw do

  # ORIGINAL ROUTES COMMENTED OUT

  # resources :reviews, only: [:edit, :update, :destroy]
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  # resources :orders, only: [:new, :update]
  get '/orders/new', to: 'orders#new'
  patch '/orders/:id', to: 'orders#update'

  # resources :items, except: [:new, :create] do
  #   resources :reviews, only: [:new, :create]
  # end

  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destroy'

  get '/items/:item_id/reviews/new', to: 'reviews#new'
  post '/items/:item_id/reviews', to: 'reviews#create'

  # resources :merchants
  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id', to: 'merchants#show'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'


  # get "/", to: "home#index"
  root 'home#index'

  # get "/merchants/:merchant_id/items", to: "items#index"
  # get "/merchants/:merchant_id/items/new", to: "items#new"
  # post "/merchants/:merchant_id/items", to: "items#create"
  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  # Cart is not a resource, it's a session - keeping these as-is
  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  patch "/cart", to: "cart#increment_decrement"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  post "/users/:id/orders", to: "orders#create"
  get "/profile/orders/:order_id", to: "orders#show"
  get '/profile/orders', to: 'orders#index'

  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/profile", to: "users#show"
  get "/profile/edit", to: "users#edit"
  patch "/profile", to: "users#update"
  get "/profile/edit_password", to: "users#edit_password"
  patch "/profile/edit_password", to: "users#update_password"

  # These are session-based - keeping as-is
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :merchant do
    # get '/', to: 'dashboard#index'
    root 'dashboard#index'
    patch '/items/:id/activation', to: 'items#activate'
    # resources :items, except: [:show]
    get '/items', to: 'items#index'
    get '/items/new', to: 'items#new'
    post '/items', to: 'items#create'
    get '/items/:id/edit', to: 'items#edit'
    patch '/items/:id', to: 'items#update'
    delete '/items/:id', to: 'items#destroy'

    # resources :item_orders, only: [:update]
    patch '/item_orders/:id', to: 'item_orders#update'

    # resources :orders, only: [:show]
    get '/orders/:id', to: 'orders#show'
  end

  namespace :admin do
    resources :merchants, only: [:show]
    # get '/', to: 'dashboard#index'
    root 'dashboard#index'
    patch '/merchants/:id/:enable_disable', to: 'merchants#update'
    resources :users, only: [:index, :show, :edit, :update] do
      resources :orders, only: [:index, :show]
    end
    get '/users/:id/edit_password', to: 'users#edit_password'
    patch '/users/:id/edit_password', to: 'users#update_password'
  end
end
