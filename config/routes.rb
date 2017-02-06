Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :requests
  resources :invitations
  get '/login', to: 'sessions#new'

  post '/login' , to: 'sessions#create' 

  delete '/logout' , to: 'sessions#destroy'

  post '/respond' , to: 'invitations#respond'

  post '/request_respond' , to: 'requests#request_respond'  

  resources :groups
  resources :users
  root 'users#index'
end
