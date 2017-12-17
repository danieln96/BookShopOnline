Rails.application.routes.draw do
  
  root "pages#home"
  get 'about', to: 'pages#about'
  resources :books
  get 'register', to: 'users#new'
  resources :users, except: [:new]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :addresses, path: 'addresses', except: [:destroy]
  
  resources :orders, except: [:create, :update, :edit]
    get 'place_order', to: 'orders#edit'
  resources :item_orders, only: [:destroy]
  get 'item_orders', to: 'item_orders#create'
  get 'edit_item_orders', to: 'item_orders#edit'

  resources :deliveries

end
