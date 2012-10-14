class Authentication < ActiveRecord::Base
  attr_accessible :nickname, :provider, :uid

  belongs_to :account
end
