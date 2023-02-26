Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  resources :properties, only: [:update, :show] do
    collection do
      get "all"
      get "available"
    end

    member do
      post "book_appointment"
    end
  end

  resources :appointments, only: [:index] do
    
  end

  root "properties#available"
end
