Rails.application.routes.draw do
  root 'home#index'

  get '/contact', to: 'home#contact' # creates contact_path and contact_url
 

end
