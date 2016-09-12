Rails.application.routes.draw do
  get 'models/index'

  resources :models
end
