class Course < ActiveRecord::Base
  attr_accessible :description, :logo_url, :platform_id, :title, :url, :platform

  belongs_to :platform
  has_many :chapters

  def as_json(options={})
    super :include => :platform
  end
end
