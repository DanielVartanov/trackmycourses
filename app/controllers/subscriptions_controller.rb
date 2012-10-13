class SubscriptionsController < ApplicationController
  def create
    session[:course_ids] = params[:subscription][:course_ids]
    render json: '', status: 201
  end
end
