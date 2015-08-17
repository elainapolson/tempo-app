class SongsController < ApplicationController

  def index 
    @playlists = Playlist.all
  end

  def show 
    @song = Song.find(params[:id])
  end

  def search
    @song = Song.new
    @user = current_user
    @playlist = @user.playlists.first
    if !params[:query].empty?
      @songs = (SpotifyWrapper.new.search_for_song(params["query"]))[0..14]
      @search = params["query"]
    else
      redirect_to songs_search_path
    end
  end

  def create
    @song = SpotifyWrapper.new.create_song_objects(song_params["track_url"])
    @song.save
    @song.assign_bpm
    @song.sort_to_playlist(current_user)
    redirect_to user_playlists_path(current_user)
  end

  private
    def song_params
      params.require(:song).permit(:title, :artist, :track_url, :bpm, :genre, :playlist_id)
    end
  
# when a user searches for a song, display top 5
# if they click add, 
# create song object through spotify wrapper, 
# then assign bpm,
# put on playlist

end
