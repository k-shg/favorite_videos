Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/signup',   to: 'users#new'
  post '/signup',  to: 'users#create'
  get  'login',    to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:index, :show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  get 'search',    to: 'posts#search'
  resources :relationships,       only: [:create, :destroy]
end
