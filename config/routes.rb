Rails.application.routes.draw do

root "users#new"

    post '/friendship/create/:id', to: 'friendships#create'

    resources :users, only: [:new, :create, :show]  do
     resources :friendships
   end

    resources :posts, :only => [:create, :destroy, :index] do
      resources :likes, module: :posts
      resources :comments, :only => [:create, :destroy] do
        resources :likes, module: :comments
      end
    end

  resources :sessions, only: [:new, :create, :destroy]

  get "/login" => "sessions#new", as: "login"
  delete "/logout" => "sessions#destroy", as: "logout"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
