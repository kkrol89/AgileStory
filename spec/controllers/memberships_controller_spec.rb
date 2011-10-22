require 'spec_helper'

describe MembershipsController do

  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    let!(:project) { Factory(:project) }
    let!(:membership) { Factory(:membership, :project => project, :user => user) }

    describe "GET 'index'" do
      it "should assign memberships for given project" do
        get :index, :project_id => project
        assigns(:memberships).should include(membership)
      end

      context 'when there exists membership for another project' do
        let!(:another_project) { Factory(:project) }
        let!(:another_membership) { Factory(:membership, :project => another_project, :user => user) }

        it 'should not assign membership for another project' do
          get :index, :project_id => project
          assigns(:memberships).should_not include(another_membership)
          assigns(:memberships).should include(membership)
        end
      end
    end
  end

  context 'when not logged in' do
    describe "GET 'index'" do
      before { get :index, :project_id => Factory(:project) }
      it { response.should redirect_to(new_user_session_path) }
    end
  end
end
