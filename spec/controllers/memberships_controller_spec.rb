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
        assigns(:project).should == project
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
    
    describe "GET 'new'" do
      it 'should assign new membership' do
        get :new, :project_id => project
        assigns(:membership).should be_a_new(Membership)
        assigns(:project).should == project
      end
    end
    
    describe "POST 'create'" do
      context 'with valid attributes' do
        it 'should create new membership' do
          expect {
            post :create, :project_id => project, :membership => Factory.build(:membership, :project_id => project.id).attributes
          }.to change(Membership, :count).by(1)
          Membership.last.project == project
          response.should redirect_to(project_memberships_path(project))
        end
      end
      context 'with invalid attributes' do
        it 'should not create new membership' do
          expect {
            post :create, :project_id => project, :membership => {}
          }.to_not change(Membership, :count)
          response.should render_template('new')
        end
      end
    end
  end

  context 'when not logged in' do
    let(:project) { Factory(:project) }

    describe "GET 'index'" do
      before { get :index, :project_id => project }
      it { response.should redirect_to(new_user_session_path) }
    end
    
    describe "GET 'new'" do
      before { get :new, :project_id => project }
      it { response.should redirect_to(new_user_session_path) }
    end
    
    describe "POST 'create'" do
      before { get :create, :project_id => project, :membership => Factory.attributes_for(:membership, :project => project) }
      it { response.should redirect_to(new_user_session_path) }
    end
  end
end
