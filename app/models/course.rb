class Course < ActiveRecord::Base
  attr_accessible :description, :logo_url, :platform_id, :title, :url, :platform

  belongs_to :platform

  def as_json(options={})
    super :include => :platform
  end
end
