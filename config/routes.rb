Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  get '/logout', to: 'users#logout'
  get '/dashboard', to: 'users#show'
  resources :discover, only: %i[index], controller: 'users/discover'
  resources :movies, only: %i[index], controller: 'users/movies'

  resources :users, only: %i[create] do
    resources :movies, only: %i[show], controller: 'users/movies' do
      resources :viewing_party, only: %i[new create], controller: 'users/movies/viewing_parties'
    end
  end
end
