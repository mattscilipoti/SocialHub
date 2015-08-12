Rails.application.routes.draw do
  root to: 'hubs#index'
  resources :hubs
  resources :users

  # mms: I see users repeated many times.  Look into Member routes
  # mms: purpose of these routes is unclear.  How is 'users#sign_in' different from 'users#sign_in!'?  Our goal is to leave code better than we found it.
  get '/sign_in', to: 'users#sign_in'
  post '/sign_in', to: 'users#sign_in!'
  get '/sign_up', to: 'users#sign_up'
  post '/sign_up', to: 'users#sign_up!'
  get '/sign_out', to: 'users#sign_out'

end
