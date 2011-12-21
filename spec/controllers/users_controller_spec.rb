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

      it 'should not authorize' do
        should_not_authorize_for(
          -> { get :edit, :id => another_user.id },
          -> { put :update, :id => another_user.id }
        )
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { get :edit, :id => user.id },
        -> { put :update, :id => user.id }
      )
    end
  end
end
