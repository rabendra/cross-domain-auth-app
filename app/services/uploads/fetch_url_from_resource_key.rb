module Uploads
  class FetchURLFromResourceKey < BaseService
    def perform(resource_key)
      I18n.t('uploads.url.input', bucket_name: ENV['COGNITO_ANON_UPLOAD_BUCKET'], resource_key: resource_key)
    end
  end
end
