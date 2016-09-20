Rails.application.routes.draw do
  resources :models only: :index
  post '/services/register'
end
