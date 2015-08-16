class PlaylistsController < ApplicationController

  def index 
    @user = current_user
    @playlists = @user.playlists
    @spotify_user = SpotifyUserWrapper.new(@user.id)
  end
  
  def show
    @playlist = Playlist.find(params[:id])
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = billboard_user
    end
  end 

end
