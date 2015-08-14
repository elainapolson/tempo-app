class SpotifyWrapper

  require 'rspotify'

  def initialize
    RSpotify.authenticate(ENV["spotify_client_id"], ENV["spotify_client_secret"])
    
  end

  def create_user(user_credentials)
    @user = RSpotify::User.new(user_credentials)
  end

  def make_playlist(name)
    @user.create_playlist!(name)
  end

  def create_song_objects(song_ids)
    song_ids.each do |song|
      spotify_song = RSpotify::Track.find(song)
      Song.find_or_create_by(:title => spotify_song.name, :artist => spotify_song.artists.first.name, :track_url => song)
    end
  end

  

end