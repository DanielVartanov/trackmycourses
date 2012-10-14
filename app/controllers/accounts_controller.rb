class AccountsController < ApplicationController
  before_filter :find_account
  
  def create
    if logged_in?
      @account = current_user
      add_authentication
    else
      if @account.nil?
        create_account
        add_authentication
      end
      
      sign_in
    end
    
    redirect_to dashboard_index_url protocol: 'http'
  end

  protected

  def find_account
    @account = Account.joins(:authentications).where('authentications.uid = ?', uid).first
  end

  def create_account
    @account = Account.create! :course_ids => session[:course_ids]
  end

  def sign_in
    session[:user_id] = @account.id
  end

  def oauth_data
    request.env["omniauth.auth"].to_hash
  end

  def add_authentication
    @account.authentications.create! :uid => uid, :provider => provider, :nickname => nickname
  end

  def nickname
    oauth_data['info']['nickname']
  end

  def provider
    oauth_data['provider']
  end

  def uid
    oauth_data['uid']
  end
end
