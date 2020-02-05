Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'home#index'
  namespace :client do
    resources :dashboard, only: %i[index]
  end

  resources :payment_methods, only: %i[index]
end
