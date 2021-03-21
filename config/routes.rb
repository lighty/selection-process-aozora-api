Rails.application.routes.draw do
  resources :writers, only: :index
  resources :works, only: :index
end
