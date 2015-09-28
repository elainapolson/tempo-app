class PlaylistsController < ApplicationController

  def index 
    @user = current_user
    @playlists = @user.playlists
  end
  
  def show
    @playlist = Playlist.find(params[:id])
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = billboard_user
    end
  end 

  def spotify
    @playlist = Playlist.find(params[:id])
    SpotifyWrapper.new.add_playlist_to_spotify(@playlist)
    redirect_to user_playlist_path(current_user, @playlist)
  end

end
