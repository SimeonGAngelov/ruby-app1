Rails.application.routes.draw do
  resources :weather, only: [ :index, :create ]
  resources :locations, only: [ :index, :create, :destroy ]

  resources :users, only: [ :new, :create, :destroy ]
  resource  :session, only: [ :new, :create, :destroy ]

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  root "weather#index"
end
