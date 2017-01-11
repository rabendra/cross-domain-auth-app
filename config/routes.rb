Rails.application.routes.draw do

  devise_for :users

  # Sidekiq Monitoring
  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
       ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
   end if Rails.env.production?
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    devise_scope :user do
      post '/registrations' => 'registrations#create', as: :user_registration 
      post '/login' => 'sessions#create', as: :user_session      
      post '/authentication' => 'registrations#authentication', as: :user_authentication    
    end
    resources :horses 
    resources :listings
    resources :categories
  end
  # TODO: Remove once we have some routing in place
  root to: 'home#index'
end
