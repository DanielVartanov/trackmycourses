require 'spec_helper'

describe SubscriptionsController, :type => :controller do
  describe "#create" do
    context 'given various courses' do
      let(:circuits) { Course.create! }
      let(:chemistry) { Course.create! }
      let(:pharmacy) { Course.create! }

      context 'anonymous user creates a subscrtipion' do
        before do
          post :create, :subscription => { :course_ids => [circuits.id] }
        end

        it "should not create any models" do
          Subscription.count.should be_zero
          Account.count.should be_zero
        end

        it "should save course list to session" do
          session[:course_ids].should == [circuits.id.to_s]
        end

        context 'that user updates the subscription' do
          before do
            post :create, :subscription => { :course_ids => [chemistry.id, pharmacy.id] }
          end

          it "should update course list in the session" do
            session[:course_ids].should == [chemistry.id.to_s, pharmacy.id.to_s]
          end
        end
      end
    end
  end
end
