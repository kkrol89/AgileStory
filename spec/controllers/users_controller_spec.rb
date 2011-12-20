require 'spec_helper'

describe UsersController do
  let!(:user) { Factory(:user) }
  let(:user_attributes) { Factory.build(:user).attributes }

  context 'when logged in' do
    before { sign_in(user) }

    describe "GET 'edit'" do
      before { get :edit, :id => user.id }
      it { assigns(:user).should == user }
      it { response.should render_template(:edit) }
    end

    describe "PUT 'update'" do
      it 'should update user profile' do
        expect {
          put :update, :id => user.id, :user => user.attributes.merge({ :email => 'newemail@example.org' })
        }.to change{ user.reload.email }.to('newemail@example.org')
      end
    end

    context 'for another user' do
      let!(:another_user) { Factory(:user) }
      describe "GET 'edit'" do
        before { get :edit, :id => another_user.id }
        it { response.should redirect_to(root_path) }
      end

      describe "PUT 'update'" do
        it 'should not update profile' do
          expect {
            put :update, :id => another_user.id, :user => user_attributes
          }.to_not change{ another_user.reload.email }
        end
        it 'should redirect to the home page' do
          put :update, :id => another_user.id, :user => user_attributes
          response.should redirect_to(root_path)
        end
      end
    end
  end

  context 'when not logged in' do
    describe "GET 'edit'" do
      before { get :edit, :id => user.id }
      it { redirect_to(new_user_session_path) }
    end
    describe "PUT 'update'" do
      before { put :update, :id => user.id, :user => user_attributes }
      it { redirect_to(new_user_session_path) }
    end
  end
end
