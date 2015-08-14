Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['spotify_client_id'], ENV['spotify_client_secret']
end