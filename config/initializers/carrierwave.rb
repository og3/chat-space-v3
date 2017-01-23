CarrierWave.configure do |config|
  # config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: 'ap-northeaset-1'
  }

  case Rails.env
    when 'production'
      config.fog_directory = 'chatspaceimages'
      config.asset_host = 'https://s3.amazonaws.com/chatspaceimages'

    when 'development'
      config.fog_directory = 'chatspaceimages'
      config.asset_host = 'https://s3.amazonaws.com/chatspaceimages'

    when 'test'
      config.storage = :file
  end
end