class Account < ActiveRecord::Base
  attr_accessible :course_ids, :uid, :twitter_username
  
  has_many :subscriptions
  has_many :courses, :through => :subscriptions
  has_many :authentications

  def authenticated_with?(provider)
    authentications.any? { |authentication| authentication.provider == provider }
  end
end
