Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :client do
    resources :dashboard, only: %i[index]
  end

  resources :payment_methods, only: %i[index show new create]
  resources :payment_settings, only: %i[new create]

  root to: 'home#index'
end
