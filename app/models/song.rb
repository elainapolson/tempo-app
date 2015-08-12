class Song < ActiveRecord::Base
  belongs_to :category

  @@students_hash = {}

  attr_accessor(:name, :tagline, :excerpt, :picture, :profile_link)
  
  def initialize(name,tagline,excerpt,picture,profile_link)
    @name = name
    @tagline = tagline
    @excerpt = excerpt
    @picture = picture
    @profile_link = profile_link
    @@students_hash[@name] = self
  end

  def Student.students_hash
    @@students_hash
  end
end


class StudentProfile

  attr_accessor(:name, :biography, :education, :work, :social)
  
  def initialize(name, biography, education, work, social)
    @name = name
    @biography = biography
    @education = education
    @work = work
    @social = social
  end

end