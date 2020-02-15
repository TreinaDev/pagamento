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

  namespace :api do
    namespace :v1 do
      get 'client/:token/transaction_simulation',
          to: 'transaction_simulation#simulation'

      resources :payment_methods, only: %i[create]
    end
  end

  resources :payment_methods, only: %i[index show new create edit update]
  resources :payment_settings, only: %i[show new create]

  root to: 'home#index'
end
