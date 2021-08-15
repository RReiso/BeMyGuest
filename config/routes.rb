Rails.application.routes.draw do
  get 'users/show'
  root 'home#index'

  get '/contact', to: 'home#contact' # creates contact_path and contact_url

  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'

  resources :users
 

end
