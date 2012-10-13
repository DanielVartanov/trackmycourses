class Account < ActiveRecord::Base
  attr_accessible :course_ids
  
  has_many :subscriptions
  has_many :courses, :through => :subscriptions
end
