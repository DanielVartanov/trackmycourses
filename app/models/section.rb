class Section < ActiveRecord::Base
  attr_accessible :due_date, :exercise_count, :title, :chapter

  belongs_to :chapter
end
