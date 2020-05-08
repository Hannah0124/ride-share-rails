Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homepages#index"  # root_path
  patch '/drivers/:id/toggle_available', to: 'drivers#toggle_available', as: 'toggle_available'
  resources :drivers  
  resources :passengers
  resources :trips
  
  
  
  # root to: "trips#index"

  # get '/trips', to: 'trips#index', as: 'trips'

  # get '/trips/new', to: 'trips#new', as: 'new_trip' 
  # post '/trips', to: 'trips#create' 

  # get '/trips/:id', to: "trips#show", as: 'trip'

  # get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'
  # patch '/trips/:id', to: 'trips#update' 

  # delete '/trips/:id', to: 'trips#destroy'

end