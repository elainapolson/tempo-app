class SpotifyUserWrapper

  require 'rspotify'

  def initialize(uid)
    RSpotify.authenticate(ENV["spotify_client_id"], ENV["spotify_client_secret"])
    @user = RSpotify::User.find(uid)
  end

end