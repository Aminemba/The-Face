Rails.application.routes.draw do
  root "users#new"
  resources :sessions, only: [:new,:show,:destroy]
  post '/sessions', to: 'sessions#show'

  resources :users, only: [:new, :edit, :show, :index]
  post '/users', to: 'sessions#new'

  resources :friendships
  post '/friendship/create/:id', to: 'friendships#create'

  resources :posts, only: [:new , :create, :destroy, :index] do
    collection do
      post :confirm
    end
    resources :likes, module: :posts
    resources :comments, only: [:create, :destroy] do
      resources :likes, module: :comments
      end
    end
end
