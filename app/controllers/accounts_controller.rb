class AccountsController < ApplicationController
  before_filter :find_account, only: [:create]

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

    redirect_to root_url protocol: 'http'
  end

  def update
    current_user.update_attribute(:twitter_notify, params[:twitter_notify]) if (params.key?(:twitter_notify) && logged_in? && current_user.authenticated_with?("twitter"))
 
    render json: :nothing, status: 200
  end

  def sign_out
    session[:user_id] = nil
    session[:course_ids] = nil
    redirect_to root_url protocol: 'http'
  end

  def subscribe
    if logged_in?
      current_user.toggle! :twitter_notify
    end
    respond_to do |format|
      format.js
    end
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
