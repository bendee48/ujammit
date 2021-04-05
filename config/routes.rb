Rails.application.routes.draw do
  devise_for :users
  root to: 'static#homepage'
  get '/authorize', to: 'spotify#authorize'
  get '/callback', to: 'spotify#callback'
end
