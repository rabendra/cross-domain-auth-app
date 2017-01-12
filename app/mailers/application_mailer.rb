class ApplicationMailer < ActionMailer::Base
  default from: ENV['NOTIFICATION_MAILER_ADDRESS']
  layout 'mailer'
end
