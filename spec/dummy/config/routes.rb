Rails.application.routes.draw do
  resources :friday_hugs, only: :create
end
