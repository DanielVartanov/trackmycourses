require 'spec_helper'

describe CoursesController, :type => :controller do
  describe '#index' do
    def course_ids
      response_json.map{ |entry| entry['id'] }
    end
  
    context 'given various courses' do
      let!(:circuits) { Course.create! :title => "Circuits and electronics" }
      let!(:chemistry) { Course.create! :title => "Learning matters" }
      let!(:pharmacy) { Course.create! :title => "Funny matters and stuff" }

      context 'when search pattern is not provided' do
        before { get :index }
        
        it 'should just return all the courses' do
          course_ids.should == [circuits, chemistry, pharmacy].map(&:id)
        end
      end

      context 'when search pattern is provided' do
        it "should return all courses which titles has a match with a given substring" do
          get :index, :search => 'circ'
          course_ids.should == [circuits.id]

          get :index, :search => 'matter'
          course_ids.should == [chemistry.id, pharmacy.id]

          get :index, :search => 'and'
          course_ids.should == [circuits.id, pharmacy.id]
        end
      end
    end
  end
end
