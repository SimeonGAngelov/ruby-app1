Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "user/new"
  get "user/create"
  get "user/destroy"
  get "locations/index"
  get "locations/create"
  get "locations/destroy"
  resources :weather, only: [ :index, :create, :destroy ]
  resources :locations, only: [ :index, :create, :destroy ]

  resources :users, only: [ :new, :create, :destroy ]
  resource  :sessions, only: [ :new, :create, :destroy ]


    root "weather#index"
end
