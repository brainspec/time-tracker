TimeTracker::Application.routes.draw do
  match '/sessions/new', to: 'sessions#new', as: 'new_user_session'
  match '/auth/:provider/callback', to: 'sessions#create'

  root to: 'home#index'
end
