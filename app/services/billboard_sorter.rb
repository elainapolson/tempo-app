class BillboardSorter

  require 'json'
  require 'open-uri'

  def initialize
    @user = User.find_or_create_by(name: "Billboard Hot 100")
    @user.give_playlists
    @user.save
  end

  def get_top_songs
    html = open("http://www.billboard.com/charts/hot-100").read
    doc = Nokogiri::HTML(html)
    spotify_ids = doc.search(".spotify").collect {|song| song.attributes["href"].value.gsub("https://embed.spotify.com/?uri=spotify:track:","")}
  end

  def call 
    song_ids = self.get_top_songs
    songs = song_ids.collect {|song_id| SpotifyWrapper.new.create_song_objects(song_id)}
    songs.each {|song| song.assign_bpm}
    songs.each {|song| song.sort_to_playlist(@user)}
  end 

  def self.sort
    self.new.call
  end

end