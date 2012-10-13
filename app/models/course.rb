class Course < ActiveRecord::Base
  attr_accessible :description, :logo_url, :platform_id, :title, :url, :platform

  belongs_to :platform
  has_many :chapters

  scope :started, -> { where "start_date <= ?", Date.today }

  def started?
    Date.today >= start_date
  end

  def as_json(options={})
    super :include => :platform
  end
end
