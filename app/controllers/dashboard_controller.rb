class DashboardController < ApplicationController
  def index
    courses = Course.find session[:course_ids]
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

    render json: {
      total_lecture_count: total_lecture_count.to_i,
      total_practice_count: total_practice_count.to_i,
      total_assignment_count: total_assignment_count.to_i
    }
  end
end