class SongSorter
  require 'json'
  require 'open-uri'

  def initialize
    @echonest_api = ENV["echonest_api_key"]
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

  def call 
    BillboardScraper.new.get_top_songs
    CategoryCreator.new.define_categories
    binding.pry
    assign_bpms
    sort_into_category
  end 

  def self.sort
    self.new.call
  end

end