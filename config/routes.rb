Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: "homepages#index"  # root_path
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


# rails new . 

# Bundle install 

# Rails db:create

# Rails s  => working! 

# rails db:migrate

# Update routes (restful routes) 

# rails generate controller Homepages

# rails generate controller Trips
# => update controller

#  touch app/views/homepages/index.html.erb (terminal)
# Update index.html.erb


# rails generate model Trip date:string rating:integer cost:float
# rails db:migrate

