require 'json'
require 'open-uri'
require 'pry'

class SongSorter

  def get_spotify_json
    JSON.load(open "http://charts.spotify.com/api/tracks/most_streamed/us/weekly/latest")
  end

  def get_song_objects(hash)
    hash["tracks"].each do |song_hash|
      Song.create(:title => song_hash['track_name'], :artist => song_hash['artist_name'], :track_url => song_hash['track_url'].gsub("https://play.spotify.com/track/", ""))
    end
  end

# For each of those song objects, we need to assign a tempo


  # http://developer.echonest.com/api/v4/song/profile?api_key=LIEBMXRVRAQ7FSQIX&track_id=spotify:track:4toSP60xmDNCFuXly8ywNZ&bucket=id:spotify&bucket=audio_summary
  
  def get_echonest_url(track_url)
    "http://developer.echonest.com/api/v4/song/profile?api_key=LIEBMXRVRAQ7FSQIX&track_id=spotify:track:#{track_url}&bucket=id:spotify&bucket=audio_summary" 
  end

  def get_url_for_a_song(song_track)
    get_echonest_url(song_track)
  end

  def assign_bpms
    Song.all.each do |song|
      binding.pry
      get_echonest_url(song.track_url)
      json_link = get_url_for_a_song(song)
      JSON.load(open "#{json_link}")
      song.bpm = hash[:response][:songs][0][:audio_summary][:tempo]
    end
  end

  def define_categories
    categories = [Category.create(:name => "Sleep"), Category.create(:name => "Study"), Category.create(:name => "Party"), Category.create(:name => "Workout")]
  end

  def all_songs 
    Song.all
  end

  def sort_into_category(songs)
    songs.each do |song|
      if song.bpm < 50 
        song.category = Category.find_by(:name => "Sleep")
        song.save
      elsif song.bpm >= 50 && song.bpm < 70
        song.category = Category.find_by(:name => "Study")
        song.save
      elsif song.bpm >= 70 && song.bpm < 100  
        song.category = Category.find_by(:name => "Party")
        song.save
      else 
        song.category = Category.find_by(:name => "Workout")
        song.save
      end
    end
  end

  def self.sort
    self.new.call
  end

  def call 
    define_categories
    spotify_hash = get_spotify_json
    get_song_objects(spotify_hash)
    # echonest_hash = get_echonest_json
    get_echonest_url(song)
    assign_bpm(echonest_hash)
    sort_into_category(all_songs)
  end 

end
