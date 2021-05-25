Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :records, only: [ :index, :create, :destroy ] do 
        resources :likes, only:[:create, :destroy]
      end
      
      resources :user, only: [:show] do
        resources :likes, only: [:index]
      end 

      post 'authenticate', to: 'authentication#create'
      delete '/likes/:id', to: 'likes#destroy'
    end
  end
end
