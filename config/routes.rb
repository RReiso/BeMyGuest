Rails.application.routes.draw do
  root 'home#index'
  get "/login", to: "home#index"
  post '/', to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  get '/contact', to: 'home#contact' # creates contact_path and contact_url

  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'


  resources :users do
    resources :events, only: %i[create show update destroy] do
      resources :tasks, only: %i[index create update destroy]
    end
  end

  # post '/tasks/:id', to: 'tasks#update_task_state'
  post '/users/:user_id/events/:event_id/task/:id', to: 'tasks#update_task_state'
 

end
