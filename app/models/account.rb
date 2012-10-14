class Account < ActiveRecord::Base
  attr_accessible :course_ids, :uid, :twitter_username, :twitter_notify
  
  has_many :subscriptions
  has_many :courses, :through => :subscriptions
  has_many :authentications

  def authenticated_with?(provider)
    authentications.any? { |authentication| authentication.provider == provider }
  end
end
