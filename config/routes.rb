Rails.application.routes.draw do
  devise_for :event_organizers,
  defaults: { format: :json },
  path: "event_organizers",
  controllers: {
    registrations: "event_organizers/registrations",
    sessions: "event_organizers/sessions"
  }

    devise_for :customers,
    defaults: { format: :json },
    controllers: {
      registrations: "customers/registrations",
      sessions: "customers/sessions"
    }
  resources :events, only: [ :index, :show ]
  namespace :event_organizers do
      resources :events, only: [ :create, :update, :destroy ]
  end
  namespace :customers do
    resources :bookings, only: [ :create ]
  end
  # resources :events, only: [ :create ]
  # namespace :api do
  # resources :events, only: [ :index, :create, :update ]
  # resources :bookings, only: [ :create ]
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
