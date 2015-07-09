class SongsController < ApplicationController


  def index 
    @categories = Category.all
  end

  def show 
    @song = Song.find(params[:id])
  end

end
