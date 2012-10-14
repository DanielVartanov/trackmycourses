require 'spec_helper'

describe AccountsController, :type => :controller do
  describe '#create' do
    context 'when user is new (user signs up)' do
      context 'given various courses' do
        let(:circuits) { Course.create! }
        let(:chemistry) { Course.create! }
        let(:pharmacy) { Course.create! }

        let(:uid) { '16271895' }
        let(:twitter_username) { 'daniel_vartanov' }
        
        context 'when it returns positive' do
          before { session[:course_ids] = subscribed_course_ids }
          
          before do
              request.env["omniauth.auth"] = {
                'uid' => uid,
                'provider' => 'twitter',
                'info' => { 'nickname' => twitter_username }
              }
              
              post :create
          end

          context 'when user has subscriptions' do
            let(:subscribed_course_ids) { [circuits.id, chemistry.id, pharmacy.id] }
            
            it 'should create a user' do
              Account.count.should == 1
            end

            it 'should sign in as that new user' do
              session[:user_id].should == Account.last.id
            end

            describe 'newly created account' do
              subject { Account.last }

              its(:uid) { should == uid }
              its(:twitter_username) { should == twitter_username }
              its(:courses) { should == [circuits, chemistry, pharmacy] }
            end
          end

          context 'when user has no subcscriptions' do
            let(:subscribed_course_ids) { nil }

            it 'should create user without subscriptions' do
              Account.last.courses.should == []
            end
          end
        end

        context 'when it returns negative' do
          pending
        end
      end
    end

    context 'when user already exists (user signs in)' do
      pending
    end
  end
end
