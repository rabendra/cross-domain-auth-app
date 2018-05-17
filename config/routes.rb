Rails.application.routes.draw do

  devise_for :users

  namespace :api, path: '', defaults: { format: :json } do
    devise_scope :user do
      # Login
      resources :sessions, only: :create
      # Registration
      resources :registrations, only: :create
      # post 'authenticate' => 'registrations#authenticate'
      match 'registrations/:provider', to: 'registrations#auth_with_provider', via: [:post]

    end
    resources :users, only: :index
  end

end
