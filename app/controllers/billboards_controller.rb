class BillboardsController < ApplicationController

  def index
    @billboard = billboard_user
    @playlists = @billboard.playlists
  end

  # def show
  #   @billboard = billboard_user
  #   @playlists = @billboard.playlists
  # end
  
end
