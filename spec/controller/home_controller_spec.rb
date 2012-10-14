require 'spec_helper'

describe HomeController, type: :controller do
  describe '#index' do
    subject { response }
    
    context 'when user is signed in' do
      before { session[:user_id] = current_user.id }

      before { get :index }
      
      context 'when user has subscriptions' do
        let(:course) { Course.create! }
        let(:current_user) { Account.create! :course_ids => [course.id] }

        it { should redirect_to('/dashboard') }
      end

      context 'when user has no subscriptions' do
        let(:current_user) { Account.create! }

        before { get :index }
        
        it { should redirect_to('/account/subscriptions') }
      end
    end

    context 'when user is not signed in' do
      before { get :index }
      
      it { should render_template('index') }
    end
  end
end
