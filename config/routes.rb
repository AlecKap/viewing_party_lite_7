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
  # get '/movies', to: 'users/movies#index'
  # get '/movies/:id', to: 'users/movies#show'
  # get '/movies/:id/viewing_party', to: 'users/movies/viewing_parties#new'
  # post '/movies/:id/viewing_party', to: 'users/movies/viewing_parties#create'

  resources :movies, only: %i[index show], controller: 'users/movies' do
    resources :viewing_party, only: %i[new create], controller: 'users/movies/viewing_parties'
  end
  resources :users, only: %i[create]
  # resources :discover, only: %i[index], controller: 'users/discover'
end
