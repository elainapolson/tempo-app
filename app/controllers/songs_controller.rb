class SongsController < ApplicationController


  def index 
    @categories = Category.all
  end

  def show 
    @songs = Song.all
  end

end
