class Chapter < ActiveRecord::Base
  attr_accessible :title, :course, :number

  belongs_to :course
  has_many :sections
  has_many :lectures
  has_many :assignments

  def as_json(options={})
    super include: { course: { include: :platform }, lectures: {}, assignments: {} }
  end
end
