class SessionsController < ApplicationController

  require 'rspotify'

  def new
  end

  def create     
    auth = request.env["omniauth.auth"]     
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)   
    session[:user_id] = user.id     
    redirect_to root_url, :notice => "Signed in!"
    $spotify_user = RSpotify::User.new(auth)
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
