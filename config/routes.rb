Rails.application.routes.draw do
  resources :models
  resources :services do 
    resources :register, only: :create
  end
end
