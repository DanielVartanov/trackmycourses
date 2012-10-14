class Chapter < ActiveRecord::Base
  attr_accessible :title, :course

  belongs_to :course
  has_many :sections
  has_many :lectures
  has_many :assignments
end
