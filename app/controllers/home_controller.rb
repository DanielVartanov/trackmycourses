class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to current_user.courses.any? ? dashboard_index_url(protocol: 'http') : account_subscriptions_url(protocol: 'http')
    end
  end
end
