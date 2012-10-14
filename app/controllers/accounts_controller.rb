class AccountsController < ApplicationController
  def create
    account = Account.find_by_uid(oauth_data['uid'])

    if account.nil?
      account = Account.create! :course_ids => session[:course_ids], :uid => oauth_data['uid'], :twitter_username => oauth_data['info']['nickname']
    end

    sign_in_as account

    redirect_to dashboard_index_url protocol: 'http'
  end

  protected

  def sign_in_as(account)
    session[:user_id] = account.id
  end

  def oauth_data
    request.env["omniauth.auth"].to_hash
  end
end
