Rails.application.routes.draw do
  namespace :service do
    resources :model
  end
end
