class CategoryCreator

  def define_categories
    categories = [Category.find_or_create_by(:name => "Sleep"), Category.find_or_create_by(:name => "Study"), Category.find_or_create_by(:name => "Party"), Category.find_or_create_by(:name => "Workout")]
  end

end