Rails.application.routes.draw do
    resources :weather, only: [ :index, :create ]
    root "weather#index"
end
