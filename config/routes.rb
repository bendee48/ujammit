Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'static#homepage'
  get '/authorize', to: 'spotify#authorize'
  get '/callback', to: 'spotify#callback'
  resources :users, only: [:show]
end
