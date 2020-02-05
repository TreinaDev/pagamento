Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients

  namespace :admin do
    resources :client_profiles
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
