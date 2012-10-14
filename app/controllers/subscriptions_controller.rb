class SubscriptionsController < ApplicationController
  def create
    session[:course_ids] = params[:subscription][:course_ids]
    render json: '', status: 201
  end

  def index
    render :json => session[:course_ids] || []
  end
end
