require 'spec_helper'

describe Course do
  fixtures :courses
  fixtures :chapters

  let(:course) { Course.find(2) }

  describe '#chapter_at_week' do
    subject { course.chapter_at_week(week) }

    context 'Course has chapter for current week' do
      let(:week) { 37 }

      it { should == course.chapters.second }
    end

    context "course hasn't started yet" do
    end
  end
end