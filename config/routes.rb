Rails.application.routes.draw do
  root 'static#homepage'
  get '/authorize', to: 'spotify#authorize'
end
