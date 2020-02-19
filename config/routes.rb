Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients

  namespace :admin do
    resources :client_profiles
    resources :payment_companies
  end

  namespace :client do
    resources :dashboard, only: %i[index]
    resources :client_profiles, only: %i[show edit update]
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'client/:token/transaction_simulation',
          to: 'transaction_simulation#simulation'

      post 'client/:client_token/order',
           to: 'orders#create'
      get 'client/:token/payment_methods',
          to: 'payment_methods#index'
    end
  end

  resources :payment_methods, only: %i[index show new create edit update]
  resources :payment_settings, only: %i[index show new create]

  root to: 'home#index'
end
