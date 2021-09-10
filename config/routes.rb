Rails.application.routes.draw do
  get 'guests/index'
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
  post '/users/:user_id/events/:event_id/notes', to: 'events#save_notes'

  get '/users/:user_id/events/:event_id/guests', to: 'connections#index', as: :guests
  get '/users/:user_id/events/:event_id/guests/contact_list', to: 'connections#contact_list', as: :contact_list

  resources :users do
    resources :contacts, only: %i[index create update destroy]
    resources :events, only: %i[create show update destroy] do
      resources :connections, only: %i[create update destroy]
      resources :tasks, only: %i[index create update destroy update_task_state]
      resources :items, only: %i[index create update destroy update_item_state]
      resources :guests, only: %i[index]
    end
  end

 

end
