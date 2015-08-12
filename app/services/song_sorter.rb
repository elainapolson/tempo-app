require 'json'
require 'open-uri'

class SongSorter

  def initialize
    @echonest_api = ENV["echonest_api_key"]
  end

  # switched to scraping from spotify to billboard
  # def get_spotify_json
  #   JSON.load(open "http://charts.spotify.com/api/tracks/most_streamed/us/weekly/latest")
  # end

  def get_song_objects(hash)
    hash["tracks"][1..100].each do |song_hash|
      Song.find_or_create_by(:title => song_hash['track_name'], :artist => song_hash['artist_name'], :track_url => song_hash['track_url'].gsub("https://play.spotify.com/track/", ""))
    end
  end
  
  def get_echonest_url(track_url)
    "http://developer.echonest.com/api/v4/song/profile?api_key=#{@echonest_api}&track_id=spotify:track:#{track_url}&bucket=id:spotify&bucket=audio_summary" 
  end

  def assign_bpms
    Song.all.each do |song|
      json_link = get_echonest_url(song.track_url)
      hash = JSON.load(open "#{json_link}")
      if hash["response"]["songs"]
        song.bpm = hash["response"]["songs"][0]["audio_summary"]["tempo"]
      end
      song.save
    end
  end

  def define_categories
    categories = [Category.find_or_create_by(:name => "Sleep"), Category.find_or_create_by(:name => "Study"), Category.find_or_create_by(:name => "Party"), Category.find_or_create_by(:name => "Workout")]
  end

  def sort_into_category
    Song.all.each do |song|
      if song.bpm
        if song.bpm < 70 
          song.category = Category.find_by(:name => "Sleep")
          song.save
        elsif song.bpm >= 70 && song.bpm < 90
          song.category = Category.find_by(:name => "Study")
          song.save
        elsif song.bpm >= 90 && song.bpm < 120  
          song.category = Category.find_by(:name => "Party")
          song.save
        else 
          song.category = Category.find_by(:name => "Workout")
          song.save
        end
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
    assign_bpms
    sort_into_category
  end 

end