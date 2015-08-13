class BillboardScraper
  require 'open-uri'
  require 'nokogiri'

  def get_top_songs
    html = open("http://www.billboard.com/charts/hot-100").read
    doc = Nokogiri::HTML(html)
    spotify_ids = doc.search(".spotify").collect {|song| song.attributes["href"].value.gsub("https://embed.spotify.com/?uri=spotify:track:","")}

    SpotifyWrapper.new(spotify_ids).create_song_objects
  end

end

