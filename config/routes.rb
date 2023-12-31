Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do 
    namespace :v1 do 
      get "merchants/find", to: 'merchants/find#index'

      resources :merchants, only: [:index, :show] do  
        resources :items, only: [:index], module: :merchants 
      end
      
      get "items/find_all", to: 'items/find#index'
      resources :items, only: [:index, :show, :create, :destroy, :update] do 
        resources :merchant, only: [:index], module: :items
      end
    end
  end
end
