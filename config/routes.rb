Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients

  root to: 'home#index'

  resources :payment_methods, only: [:index, :show, :new, :create]
end
