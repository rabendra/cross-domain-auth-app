if Rails.env.test? || Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
  end
else

  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      region: ENV['S3_REGION'] || 'us-east-1'
    }

    config.storage = :fog
    config.fog_public = true
    config.asset_host = ENV['CLOUDFRONT_UPLOADS_HOST']
    config.fog_directory = ENV['S3_UPLOADS_BUCKET']
  end

end
