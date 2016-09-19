Rails.application.routes.draw do
  resources :models
  post '/services/register'
end
