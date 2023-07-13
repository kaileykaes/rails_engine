Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get '/api/v1/merchants/find', to: 'merchants/find#show'

  namespace :api do 
    namespace :v1 do 
      get "merchants/find", to: 'merchants/find#show'
      
      resources :merchants, only: [:index, :show] do  
        resources :items, only: [:index], module: :merchants 
      end
      
      resources :items, only: [:index, :show, :create, :destroy, :update] do 
        resources :merchant, only: [:index], module: :items
      end
    end
  end
end
