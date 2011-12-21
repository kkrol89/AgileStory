require 'spec_helper'

describe SprintsController do
  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    context 'with existing project' do
      let!(:project) { Factory(:project) }
      context 'with admin role' do
        before { assign_member(project: project, member: user, role: "admin") }

        describe "GET 'new'" do
          before { get :new, :project_id => project.id }
          it { response.should render_template(:new) }
          it { assigns(:sprint).should be_a_new(Sprint) }
        end

        describe "POST 'create'" do
          it 'should create one sprint' do
            expect {
              post :create, :project_id => project.id, :sprint => Factory.build(:sprint, :project => project).attributes
            }.to change(project.sprints, :count).by(1)
          end
        end
      end

      ["developer", "viewer"].each do |role_name|
        context "with #{role_name} role" do
          before { assign_member(project: project, member: user, role: role_name) }

          describe "GET 'new'" do
            before { get :new, :project_id => project.id }
            it { response.should redirect_to(root_path) }
          end

          describe "POST 'create'" do
            before { post :create, :project_id => project.id, :sprint => Factory.build(:sprint, :project => project).attributes }  
            it { response.should redirect_to(root_path) }
          end
        end
      end
    end
  end

  context 'when not logged in' do
    context 'with existing project' do
      let!(:project) { Factory(:project) }

      describe "GET 'new'" do
        before { get :new, :project_id => project.id }
        it { response.should redirect_to(new_user_session_path) }
      end

      describe "POST 'create'" do
        before { post :create, :project_id => project.id, :sprint => Factory.build(:sprint, :project => project).attributes }
        it { response.should redirect_to(new_user_session_path) }
      end
    end
  end
end
