TimeTracker::Application.routes.draw do
  resource :session, only: %w[new destroy]
  match '/auth/:provider/callback', to: 'sessions#create'

  resources :time_entries, only: 'create'

  root to: 'home#index'
end
