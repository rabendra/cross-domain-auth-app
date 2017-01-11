source 'https://rubygems.org'

ruby '2.3.2'

# Platform
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg'
gem 'puma', '~> 3.0'

# Authentication and access control
gem 'devise', '~> 4.2'
gem 'acts-as-taggable-on', '~> 4.0'
# Background processing
gem 'sidekiq', '~> 4.2'
gem 'sidekiq-scheduler', '~> 2.0'

# Monitoring
gem 'newrelic_rpm', '~> 3.17.2'
gem 'jwt', '~> 1.5.2'
gem 'active_model_serializers'
# Geocoding & uploads
gem 'geocoder', '~> 1.4'
gem 'carrierwave', '~> 1.0'
gem 'fog', '~> 1.38'
gem 'mini_magick', '~> 4.6'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

# API Builder
gem 'jbuilder', '~> 2.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'dotenv-rails', '~> 2.1'

  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '~> 4.7'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  gem 'foreman'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
