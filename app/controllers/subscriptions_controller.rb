class SubscriptionsController < ApplicationController
  def create
    session[:course_ids] = params[:subscription][:course_ids]
    render json: '', status: 201
  end

  def index
    respond_to do |format|
      format.html
      format.json { render :json => json }
    end
  end

  protected

  def json
    { course_ids: session[:course_ids] || [] }
  end
end
