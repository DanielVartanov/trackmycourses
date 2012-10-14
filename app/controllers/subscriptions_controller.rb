class SubscriptionsController < ApplicationController
  def create
    session[:course_ids] = params[:course_ids]
    
    if logged_in?
      current_user.update_attributes :course_ids => params[:course_ids]
    end
    
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
    course_ids = logged_in? ? current_user.courses.map(&:id) : session[:course_ids]
    { course_ids: course_ids || [] }
  end
end
