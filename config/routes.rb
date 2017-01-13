Rails.application.routes.draw do

  devise_for :users

  # Sidekiq Monitoring
  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?
  mount Sidekiq::Web => '/sidekiq'

  # devise_scope :user do
  #   post 'auth/facebook', to: 'devise_ios_rails/oauth#facebook'
  # end


  namespace :api, path: '', defaults: { format: :json } do
    devise_scope :user do

      # Login
      resources :sessions, only: :create

      # Registration
      resources :registrations, only: :create
      post 'authenticate' => 'registrations#authenticate'


      # Horses
      resources :horses, except: [:new, :edit] do
        namespace :horses, path: '' do
          resource :photo, path: :photo, only: :update
        end
      end

      # Profile Management
      resource :personal_profile, path: :profile, only: :update
      resource :business_profile, path: :business, only: :update
      resource :avatar, only: :update
      resources :contacts, only: :create
    end
  end
end
