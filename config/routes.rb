Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homepages#index"  # root_path
  patch '/drivers/:id/toggle_available', to: 'drivers#toggle_available', as: 'toggle_available'

  resources :passengers
  resources :drivers  
  resources :trips

  resources :passengers do 
    resources :trips, only: [:create, :update]
  end
end