Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  delete '/logout', to: 'users#logout_of_session'
  get '/dashboard', to: 'users#show'
  get '/users/discover', to: 'users/discover#index'

  resources :movies, only: %i[index show], controller: 'users/movies' do
    resources :viewing_party, only: %i[new create], controller: 'users/movies/viewing_parties'
  end
  resources :users, only: %i[create]

  namespace :admin do
    get '/users/:id', to: 'users#show'
    get '/users', to: 'users#index'
  end
end
