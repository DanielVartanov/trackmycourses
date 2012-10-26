class Platform < ActiveRecord::Base
  attr_accessible :logo_url, :name, :url

  has_many :courses

  def self.[](name)
    find_by_name(name.to_s)
  end

  def credentials
    self.class.config[name].symbolize_keys
  end

  protected

  def self.config
    @config ||= YAML::load(ERB.new(File.read(File.join(Rails.root, 'config', 'platforms.yml'))).result)[Rails.env]
  end
end
