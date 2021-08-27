Rails.application.routes.draw do
  root 'home#index'
  post '/', to: "sessions#create"
  get "/login", to: "home#index"

  delete "/logout", to: "sessions#destroy"

  get '/contact', to: 'home#contact' # creates contact_path and contact_url

  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'

  resources :users, only: %i[index show update destroy]
  resources :account_activations, only: %i[edit]

 

end
