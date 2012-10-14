class CoursesController < ApplicationController
  before_filter :find_courses
  
  def index
    render :json => @courses
  end

  protected

  def search?
    params.key? :search
  end

  def search_query
    "%#{params[:search]}%"
  end

  def find_courses
    @courses = search? ?
                 Course.where('title LIKE ?', search_query) :
                 Course.all
  end
end
