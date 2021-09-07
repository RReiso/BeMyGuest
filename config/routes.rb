Rails.application.routes.draw do
  get 'contacts/index'
  get 'contacts/update'
  get 'contacts/destroy'
  root 'home#index'
  get "/login", to: "home#index"
  post '/', to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'
  
  post '/users/:user_id/events/:event_id/tasks/:id', to: 'tasks#update_task_state'
  post '/users/:user_id/events/:event_id/items/:id', to: 'items#update_item_state'

  get 'users/:user_id/address-book', to: 'contacts#index', as: :address_book

  resources :users do
    resources :contacts, only: %i[create update destroy]
    resources :events, only: %i[create show update destroy] do
      resources :tasks, only: %i[index create update destroy update_task_state]
      resources :items, only: %i[index create update destroy update_item_state]
    end
  end

 

end
