class DashboardController < ApplicationController
  def index
    courses = user_courses
    chapters = courses.map { |course| course.chapter_at_week(params[:week].to_i)}
    chapters = chapters.compact

    if chapters.any?
      assignments = chapters.map(&:assignments).flatten
      lectures = chapters.map(&:lectures).flatten
      total_lecture_count = lectures.count
      total_practice_count = lectures.map(&:practice_count).inject(&:+)
      total_assignment_count = assignments.size
    else
      total_lecture_count = 0
      total_practice_count = 0
      total_assignment_count = 0
    end

    respond_to do |format|
      format.html
      format.json do
        render json: {
          total_lecture_count: total_lecture_count.to_i,
          total_practice_count: total_practice_count.to_i,
          total_assignment_count: total_assignment_count.to_i,
          chapters: chapters
        }
      end
    end
  end

  protected

  def user_courses
    if logged_in?
      current_user.courses
    else
      if session[:course_ids] 
        Course.find session[:course_ids]
      else
        []
      end
    end
  end
end
