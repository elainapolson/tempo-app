class Song < ActiveRecord::Base

  require 'json'
  require 'open-uri'

  # Song#user delegated to playlist.user
  belongs_to :playlist
  delegate :user, to: :playlist

  def assign_bpm
    bpm = EchonestWrapper.new.find_bpm(self)
    self.bpm = bpm
    self.save
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