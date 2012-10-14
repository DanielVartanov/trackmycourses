class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_user
    session.key?(:user_id) ? Account.find_by_id(session[:user_id]) : nil
  end

  def logged_in?
    current_user.present?
  end
end
