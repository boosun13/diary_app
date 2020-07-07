Rails.application.routes.draw do
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  
  resources :users
  get "/blogs/search" => "blogs#search"
  resources :blogs
  resources :memos
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/" => "top#home"
end
