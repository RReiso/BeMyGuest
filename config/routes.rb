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
  
  patch '/users/:user_id/events/:event_id/tasks/:id/state',
        to: 'tasks#update_task_state', as: :update_task_state
  patch '/users/:user_id/events/:event_id/items/:id/state', 
        to: 'items#update_item_state', as: :update_item_state
  patch '/users/:user_id/events/:event_id/notes', to: 'events#save_notes', as: :notes

  get '/users/:user_id/events/:event_id/guests', to: 'connections#index', as: :guests
  get '/users/:user_id/events/:event_id/guests/contact_list', 
      to: 'connections#contact_list', as: :contact_list

  resources :users do
    resources :contacts, only: %i[index create update destroy]
    resources :events, only: %i[create show update destroy] do
      resources :connections, only: %i[create update destroy]
      resources :tasks, only: %i[index create destroy]
      resources :items, only: %i[index create destroy]
      resources :guests, only: %i[index]
    end
  end
end
