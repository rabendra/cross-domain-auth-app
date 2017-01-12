Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  config.assets.debug = true
  config.assets.raise_runtime_errors = true
  config.assets.precompile += %w()

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options =
    { host: ENV.fetch('DOMAIN_NAME') { 'localhost:3000' } }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
end
