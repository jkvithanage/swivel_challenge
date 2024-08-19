Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :verticals
      resources :categories
      resources :courses do
        get :search, on: :collection, as: :search
      end

      resources :users, only: [:create]
    end
  end

  # Catch-all route for unrecognized requests
  match '*unmatched', to: 'application#invalid_route', via: :all
end
