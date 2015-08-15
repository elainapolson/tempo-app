class SongsController < ApplicationController

  def index 
    @playlists = Playlist.all
  end

  def show 
    @song = Song.find(params[:id])
  end
  
# when a user adds a song, 
# create song object through spotify wrapper, 
# then assign bpm

end
