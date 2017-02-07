Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  get '/login', to: 'sessions#new'

  post '/login' , to: 'sessions#create' 

  delete '/logout' , to: 'sessions#destroy'

  post '/respond' , to: 'invitations#respond'

  post '/request_respond' , to: 'requests#request_respond'  


  resources :comments
  resources :posts
  resources :requests
  resources :invitations
  
  resources :groups
  resources :users
  #root 'users#index'
  #root 'static_pages#home'
  root 'static_pages#practice'
end
