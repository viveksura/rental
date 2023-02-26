Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  resources :properties, only: [] do
    collection do
      get "all"
      get "available"
    end

    member do
      get "show"
      put "update"
      post "book_appointment"
    end
  end

  root "properties#available"
end
