# -*- coding: utf-8 -*-
require 'spec_helper'


# Если в подписках существует курс, который не стартовал к этой неделе

describe DashboardController, :type => :controller do
  describe '#index' do
    context 'format: json' do
      context 'given a couple of courses' do
        fixtures :courses
        fixtures :chapters
        fixtures :sections

        before do 
          session[:course_ids] = Course.all.map(&:id)
        end

        it 'should return total count for two courses' do
          get :index, week: 38, format: :json
          
          response_json["total_lecture_count"].should == 5
          response_json["total_practice_count"].should == 11
          response_json["total_assignment_count"].should == 2

          response_json["chapters"].count.should == 2
          response_json["chapters"][0]["course"].should_not be_nil
        end
      end

      context 'sending a week, when no any courses started' do
        fixtures :courses
        fixtures :chapters
        fixtures :sections

        before do 
          session[:course_ids] = Course.all.map(&:id)
        end

        it 'should return nulls if there are no started courses' do
          get :index, week: 35, format: :json

          response_json["total_lecture_count"].should == 0
          response_json["total_practice_count"].should == 0
          response_json["total_assignment_count"].should == 0
          
          response_json["chapters"].count.should == 0
        end
      end
    end  
  end
end
