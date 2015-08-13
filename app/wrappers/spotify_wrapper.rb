class SpotifyWrapper

  require 'rspotify'

  def initialize (song_ids)
    RSpotify.authenticate(ENV["spotify_client_id"], ENV["spotify_client_secret"])
    @song_ids = song_ids
  end

  def create_song_objects
    binding.pry
    @song_ids.each do |song|
      spotify_song = RSpotify::Track.find(song)
      Song.find_or_create_by(:title => spotify_song.name, :artist => spotify_song.artists.first.name, :track_url => song)
    end
  end

end