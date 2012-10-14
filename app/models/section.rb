class Section < ActiveRecord::Base
  attr_accessible :title, :url, :chapter

  belongs_to :chapter
end
