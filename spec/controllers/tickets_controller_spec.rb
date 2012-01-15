require 'spec_helper'

describe TicketsController do
  let!(:user) { Factory(:user) }

  context 'when logged in' do
    before { sign_in(user) }

    describe "GET 'index'" do
      before { get :index }
      it { assigns(:projects).should_not be_nil }
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { get :index }
      )
    end
  end
end
