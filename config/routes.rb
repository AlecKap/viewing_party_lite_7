Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  resources :users, only: [:show, :new, :create] do
    resources :discover_movies, only: [:index], controller: 'users/discover_movies'
  end
end
