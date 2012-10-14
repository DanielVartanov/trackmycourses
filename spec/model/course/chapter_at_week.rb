require 'spec_helper'

describe Course do
  describe '#chapter_at_week' do
    
    context 'Course has chapter for current week' do
      fixtures :courses
      fixtures :chapters

      let(:week) { 37 }
      let(:course) { Course.find(2) }

      it 'should return chapter object' do
        course.chapter_at_week(week).should == course.chapters.second
      end
    end

    context "Course hasn't started yet" do
      fixtures :courses
      fixtures :chapters

      let(:week) { 35 }
      let(:course) { Course.find(2) }
      
      it 'should return nil' do
        course.chapter_at_week(week).should == nil
      end
    end

  end
end