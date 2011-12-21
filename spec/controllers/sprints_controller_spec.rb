require 'spec_helper'

describe SprintsController do
  let(:project) { Factory(:project) }

  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    context 'with admin role' do
      before { assign_member(project: project, member: user, role: "admin") }

      describe "GET 'new'" do
        before { get :new, :project_id => project.id }
        it { assigns(:sprint).should be_a_new(Sprint) }
        it { response.should render_template(:new) }
      end

      describe "POST 'create'" do
        it 'should create one sprint' do
          expect {
            post :create, :project_id => project.id, :sprint => Factory.build(:sprint, :project => project).attributes
          }.to change(project.sprints, :count).by(1)
        end
      end
    end

    ["no", "developer", "viewer"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        it 'should not authorize' do
          should_not_authorize_for(
            -> { get :new, :project_id => project.id },
            -> { post :create, :project_id => project.id }
          )
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { get :new, :project_id => project.id },
        -> { post :create, :project_id => project.id }
      )
    end
  end
end
