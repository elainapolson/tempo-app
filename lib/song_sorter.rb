class SongSorter

#eventually scrap Spotify data in here and create new song objects, and sort them into categories

  @@songs = [@see_you_again = Song.create(:title => "See You Again", :artist => "Wiz Khalifa", :genre => "Hip-Hop", :bpm => 75), @bad_blood = Song.create(:title => "Bad Blood", :artist => "Taylor Swift", :genre => "Pop", :bpm => 45), @cheerleader = Song.create(:title => "Cheerleader", :artist => "OMI", :genre => "Rap", :bpm => 120) ,@trap_queen = Song.create(:title => "Trap Queen", :artist => "Fetty Wap", :genre => "Rap", :bpm => 118) ,@shut_up_and_dance = Song.create(:title => "Shut Up and Dance", :artist => "Walk the Moon", :genre => "Pop", :bpm => 145), @cant_feel_my_face = Song.create(:title => "Can't Feel My Face", :artist => "The Weeknd", :genre => "Hip-Hop", :bpm => 65),@watch_me = Song.create(:title => "Watch Me", :artist => "Silento", :genre => "Pop", :bpm => 68),@uptown_funk = Song.create(:title => "Uptown Funk!", :artist => "Bruno Mars", :genre => "Pop", :bpm => 90),@good_for_you = Song.create(:title => "Good For You", :artist => "Selena Gomez", :genre => "Pop", :bpm => 40),@hey_mama = Song.create(:title => "Hey Mama", :artist => "David Guetta", :genre => "Pop", :bpm => 87),@honey_im_good = Song.create(:title => "Honey I'm Good", :artist => "Andy Grammer", :genre => "Country", :bpm => 40),@want_to_want_me = Song.create(:title => "Want To Want Me", :artist => "Jason Derulo", :genre => "Hip-Hop", :bpm => 55)]

  @@categories = [@sleep = Category.create(:name => "sleep"), @study = Category.create(:name => "study"), @party = Category.create(:name => "party"), @workout = Category.create(:name => "workout")]

  def sort_into_category(songs)
    songs.each do |song|
      if song.bpm < 50 
        song.category = Category.find_by(:name => "sleep")
        song.save
      elsif song.bpm >= 50 && song.bpm < 70
        song.category = Category.find_by(:name => "study")
        song.save
      elsif song.bpm >= 70 && song.bpm < 100 
        song.category = Category.find_by(:name => "party")
        song.save
      else 
        song.category = Category.find_by(:name => "workout")
        song.save
      end
    end
  end

  def self.sort
    self.new.call
  end

  def call 
    sort_into_category(@@songs)
  end 

end
