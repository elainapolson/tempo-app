class Song < ActiveRecord::Base

  require 'json'
  require 'open-uri'

  # Song#user delegated to playlist.user
  belongs_to :playlist
  delegate :user, to: :playlist

  def assign_bpm
    json_link = EchonestWrapper.new.get_echonest_url(self.track_url)
    hash = JSON.load(open "#{json_link}")
    if hash["response"]["songs"]
      self.bpm = hash["response"]["songs"][0]["audio_summary"]["tempo"]
      self.save
    else
      # do something when there are no songs found...
    end
  end

  def sort_to_playlist(user)
    if self.bpm
      if self.bpm < 70 
        self.playlist = Playlist.find_by(:name => "Sleep", :user_id => user.id)
        self.save
      elsif self.bpm >= 70 && self.bpm < 90
        self.playlist = Playlist.find_by(:name => "Study", :user_id => user.id)
        self.save
      elsif self.bpm >= 90 && self.bpm < 120  
        self.playlist = Playlist.find_by(:name => "Party", :user_id => user.id)
        self.save
      else 
        self.playlist = Playlist.find_by(:name => "Workout", :user_id => user.id)
        self.save
      end
    end
  end


# when a user adds a song, 
# create song object through spotify wrapper, 
# then assign bpm

end