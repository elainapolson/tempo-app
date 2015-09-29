class User < ActiveRecord::Base

  has_many :playlists
  has_many :songs, through: :playlists

  validates :name, :presence => true

  def give_playlists
    Playlist.find_or_create_by(:name => "Sleep", :user_id => self.id)
    Playlist.find_or_create_by(:name => "Study", :user_id => self.id)
    Playlist.find_or_create_by(:name => "Party", :user_id => self.id)
    Playlist.find_or_create_by(:name => "Workout", :user_id => self.id)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["display_name"]
    end
  end

end
