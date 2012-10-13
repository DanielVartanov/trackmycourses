class Account < ActiveRecord::Base
  has_many :subscriptions
  has_many :courses, :through => :subscriptions
end
