TimeTracker::Application.routes.draw do
  resource :session, only: %w[new destroy]
  match '/auth/:provider/callback', to: 'sessions#create'

  resources :time_entries, only: %w[create destroy index]

  match '/403', to: 'home#access_denied'

  root to: 'home#index'
end
