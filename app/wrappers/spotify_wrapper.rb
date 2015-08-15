class SpotifyWrapper

  require 'rspotify'

  def initialize
    RSpotify.authenticate(ENV["spotify_client_id"], ENV["spotify_client_secret"])
  end

  def create_song_objects(song_id)
    spotify_song = RSpotify::Track.find(song_id)
    Song.find_or_create_by(:title => spotify_song.name, :artist => spotify_song.artists.first.name, :track_url => song_id)
  end

end


# when a user adds a song, create song object through spotify wrapper, 
# then assign bpm