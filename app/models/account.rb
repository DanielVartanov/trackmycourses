class Account < ActiveRecord::Base
  attr_accessible :course_ids, :uid, :twitter_username
  
  has_many :subscriptions
  has_many :courses, :through => :subscriptions
  has_many :authentications
end
