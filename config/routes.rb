Rails.application.routes.draw do

  devise_for :users

  # Sidekiq Monitoring
  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, path: '', defaults: { format: :json } do
    devise_scope :user do
      resources :sessions, only: :create
      resources :horses, only: :create
      resource :avatar, only: :update
    end
  end

  # TODO: Remove once we have some routing in place
  root to: 'home#index'
end
