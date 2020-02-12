Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients

  namespace :admin do
    resources :client_profiles
    resources :payment_companies
  end

  namespace :client do
    resources :dashboard, only: %i[index]
  end

  resources :payment_methods, only: %i[index show new create]
  resources :payment_settings, only: %i[show new create]

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :payment_methods, only: %i[index]
    end
  end
end
