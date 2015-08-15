class EchonestWrapper
  require 'json'
  require 'open-uri'

  def initialize
    @echonest_api = ENV["echonest_api_key"]
  end
  
  def get_echonest_url(track_url)
    "http://developer.echonest.com/api/v4/song/profile?api_key=#{@echonest_api}&track_id=spotify:track:#{track_url}&bucket=id:spotify&bucket=audio_summary" 
  end

end