class BillboardsController < ApplicationController

  def index
    @billboard = User.find_by(:name => "Billboard Hot 100")
    @playlists = @billboard.playlists
  end

  # def show
  #   @billboard = billboard_user
  #   @playlists = @billboard.playlists
  # end
  
end
