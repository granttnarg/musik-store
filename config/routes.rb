Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :records, only: [ :index, :destroy ] do 
        resources :likes, only:[:create, :destroy]
      end

      resources :artists, only: [:show] do
        resources :records, only: [:create]
      end
      
      resources :users, only: [:show] do
        resources :likes, only: [:index]
      end 

      post 'authenticate', to: 'authentication#create'
      delete '/likes/:id', to: 'likes#destroy'
    end
  end
end
