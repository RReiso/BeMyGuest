Rails.application.routes.draw do
  root 'home#index'
  get "/login", to: "home#index"
  post '/', to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  get '/contact', to: 'home#contact' # creates contact_path and contact_url

  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'

  resources :users
 

end
