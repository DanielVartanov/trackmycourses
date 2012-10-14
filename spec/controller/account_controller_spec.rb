require 'spec_helper'

describe AccountsController, :type => :controller do
  describe '#update' do
    let(:circuits) { Course.create! }
    let(:chemistry) { Course.create! }
    let(:pharmacy) { Course.create! }

    let(:current_user) { Account.create! }
    let(:subscribed_course_ids) { [circuits.id, chemistry.id, pharmacy.id] }

    context 'when user has connected twitter account' do
      let(:twitter_uid) { '643321084' }
      let(:twitter_username) { 'daniel.vartanov' }

      before do
        current_user.authentications.create! :provider => 'twitter', :uid => twitter_uid, :nickname => twitter_username
      end

      context 'when user is logged in' do
        before do
          session[:user_id] = current_user.id
          session[:course_ids] = subscribed_course_ids
        end
        
        context 'when notifications disabled' do
          it 'should update twitter notification' do
            put :update, twitter_notify: true

            response.status.should == 200

            current_user.reload
            current_user.twitter_notify.should be_true
          end
        end

        context 'when notifications enabled' do
          before { current_user.update_attribute(:twitter_notify, true) }

          it 'should update twitter notification' do
            put :update, twitter_notify: false

            response.status.should == 200

            current_user.reload
            current_user.twitter_notify.should be_false
          end
        end

        context 'when doesnt send params' do
          it 'should do nothing with current user account' do
            put :update

            response.status.should == 200

            current_user.reload
            current_user.twitter_notify.should be_false
          end
        end
      end

      context 'when user is not logged in' do
        it 'should update twitter notification' do
          put :update, twitter_notify: true

          response.status.should == 200
          Account.last.twitter_notify.should be_false
        end
      end
    end

    context 'when user hasnt connect twitter account' do
      let(:facebook_uid) { '643321084' }
      let(:facebook_username) { 'daniel.vartanov' }

      before do
        current_user.authentications.create! :provider => 'facebook', :uid => facebook_uid, :nickname => facebook_username
        session[:user_id] = current_user.id
        session[:course_ids] = subscribed_course_ids
      end
      
      it 'should update twitter notification' do
        put :update, twitter_notify: true

        response.status.should == 200
        Account.last.twitter_notify.should be_false
      end

    end
  end

  describe '#sign_out' do
    context 'when user is logged in' do
      let(:circuits) { Course.create! }
      let(:chemistry) { Course.create! }
      let(:pharmacy) { Course.create! }

      let(:current_user) { Account.create! }
      let(:facebook_uid) { '643321084' }
      let(:facebook_username) { 'daniel.vartanov' }

      let(:subscribed_course_ids) { [circuits.id, chemistry.id, pharmacy.id] }

      before do
        current_user.authentications.create! :provider => 'facebook', :uid => facebook_uid, :nickname => facebook_username
      end

      context 'when user have session' do
        before do
          session[:user_id] = current_user.id
          session[:course_ids] = subscribed_course_ids
        end

        it 'should clear session' do
          get :sign_out

          session[:user_id].should be_nil
          session[:course_ids].should be_nil
        end
      end

      context 'when user doesnt have session' do
        it 'should not expose an error' do
          get :sign_out

          session[:user_id].should be_nil
          session[:course_ids].should be_nil
        end
      end
    end
  end

  describe '#create' do
    context 'when user is new (user signs up)' do
      context 'given various courses' do
        let(:circuits) { Course.create! }
        let(:chemistry) { Course.create! }
        let(:pharmacy) { Course.create! }

        let(:twitter_uid) { '16271895' }
        let(:twitter_username) { 'daniel_vartanov' }

        let(:subscribed_course_ids) { [circuits.id, chemistry.id, pharmacy.id] }
        
        context 'when it returns positive' do
          before { session[:course_ids] = subscribed_course_ids }
          
          before do
            request.env["omniauth.auth"] = {
              'uid' => twitter_uid,
              'provider' => 'twitter',
              'info' => { 'nickname' => twitter_username }
            }
          end

          context 'when user has subscriptions' do
            before { post :create }
            
            let(:subscribed_course_ids) { [circuits.id, chemistry.id, pharmacy.id] }
            
            it 'should create a user' do
              Account.count.should == 1
            end

            it 'should sign in as that new user' do
              session[:user_id].should == Account.last.id
            end

            describe 'newly created account' do
              subject { Account.last }

              its(:courses) { should == [circuits, chemistry, pharmacy] }

              it "should have twitter authentication" do
                subject.authentications.count.should == 1
                subject.authentications.first.uid.should == twitter_uid
                subject.authentications.first.provider.should == 'twitter'
                subject.authentications.first.nickname.should == twitter_username
              end
            end
          end

          context 'when user has no subcscriptions' do
            before { post :create }
            
            let(:subscribed_course_ids) { nil }

            it 'should create user without subscriptions' do
              Account.last.courses.should == []
            end
          end

          context 'when account is already created' do
            let(:current_user) { Account.create! }
            let(:facebook_uid) { '643321084' }
            let(:facebook_username) { 'daniel.vartanov' }
            
            before do
              current_user.authentications.create! :provider => 'twitter', :uid => twitter_uid, :nickname => twitter_username
            end
            
            before do
              request.env["omniauth.auth"] = {
                'uid' => facebook_uid,
                'provider' => 'facebook',
                'info' => { 'nickname' => facebook_username }
              }
            end

            before { session[:user_id] = current_user.id }

            before { post :create }

            it 'should keep user signed in' do
              session[:user_id].should == current_user.id
            end

            it 'shuold add new authentication' do
              current_user.reload
              current_user.authentications.count.should == 2
              current_user.authentications.last.uid.should == facebook_uid
              current_user.authentications.last.provider.should == 'facebook'
              current_user.authentications.last.nickname.should == facebook_username
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
