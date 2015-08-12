require 'open-uri'
require 'nokogiri'
require 'pry'

class BillboardScraper

  def create_top_songs
    html = open("http://www.billboard.com/charts/hot-100").read
    doc = Nokogiri::HTML(html)
    
    songs = doc.search(".spotify").collect {|song| song}
    spotify_links = songs.collect {|s| s.attributes["href"].value}

    names.each_with_index do |name,index| 
      Student.new(name,taglines[index],excerpts[index],pictures[index],links[index])
    end

    Student.students_hash

  end


end