Rails.application.routes.draw do
  root to: 'hubs#index'

  resources :hubs
end
