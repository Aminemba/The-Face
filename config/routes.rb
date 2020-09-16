Rails.application.routes.draw do
  root "users#new"

  resources :sessions,only: [:new , :create, :destroy]
  get "/sessions/:id", to: "sessions#destroy"

  # controller :sessions do
  # get  'login' => :new
  # post 'login' => :create
  # delete 'logout' => :destroy
  # end

  resources :users
  # post "/users", to: "sessions#new"


  resources :friendships
  post '/friendship/create/:id', to: 'friendships#create'

  resources :posts do
    collection do
      post :confirm
      patch :confirm
    end
    resources :likes, module: :posts
    resources :comments, only: [:create, :destroy] do
      resources :likes, module: :comments
      end
    end
end
