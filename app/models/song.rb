class Song < ActiveRecord::Base
  belongs_to :category

end


# Sleep - 1 -- > 0 - 50
# Study - 2 → 50 - 70
# Party - 3 → 70 - 100
# Workout - 4 → 100 and higher