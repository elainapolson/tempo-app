class SpotifyWrapper

  require 'rspotify'

  def initialize
    RSpotify.authenticate(ENV["spotify_client_id"], ENV["spotify_client_secret"])
  end

  def create_song_objects(song_id)
    spotify_song = RSpotify::Track.find(song_id)
    Song.find_or_create_by(:title => spotify_song.name, :artist => spotify_song.artists.first.name, :track_url => song_id)
  end

  def search_for_song(query)
    RSpotify::Track.search(query)
  end

end