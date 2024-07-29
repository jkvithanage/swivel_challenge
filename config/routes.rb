Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :verticals
      resources :categories
      resources :courses

      resources :users, only: [:create]
    end
  end
end
