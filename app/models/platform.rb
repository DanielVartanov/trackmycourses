class Platform < ActiveRecord::Base
  attr_accessible :logo_url, :name, :url

  has_many :courses

  def self.[](name)
    find_by_name(name.to_s)
  end
end
