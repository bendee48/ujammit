Rails.application.routes.draw do
  root 'static#homepage'
  get '/authorize', to: 'spotify#authorize'
  get '/callback', to: 'spotify#callback'
end
