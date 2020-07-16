Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/signup',   to: 'users#new'
  post '/signup',  to: 'users#create'
  get  'login',    to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  post 'guest_login',    to: 'sessions#new_guest'
  delete 'logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
    collection do
      get :search
    end
  end
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
    collection do
      get :search
    end
  end
  resources :relationships,       only: [:create, :destroy]
  get '/check', to: 'posts#check'
end
