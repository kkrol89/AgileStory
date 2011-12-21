require 'spec_helper'

describe ProjectsController do

  let(:project) { Factory(:project) }

  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    describe "GET 'new'" do
      before { get :new }
      it { assigns(:project).should be_a_new(Project) }
      it { response.should render_template('new') }
    end

    describe "POST 'create'" do
      it 'should create one project' do
        expect {
          post :create, :project => Factory.attributes_for(:project)
        }.to change(Project, :count).by(1)
        response.should redirect_to(projects_path)
      end

      it 'should create one membership' do
        expect {
          post :create, :project => Factory.attributes_for(:project)
        }.to change(Membership, :count).by(1)
        response.should redirect_to(projects_path)
      end

      it 'should assign current user as project admin' do
        post :create, :project => Factory.attributes_for(:project)
        Project.last.memberships.where(:user_id => user, :role => User::ROLES[:admin]).should_not be_empty
      end
    end

    context 'with existing project' do
      before { project }

      context 'with admin role' do
        before { assign_member(project: project, member: user, role: "admin") }

        describe "GET 'edit'" do
          before { get :edit, :id => project }
          it { assigns(:project).should == project }
          it { response.should render_template('edit') }
        end

        describe "PUT 'update'" do
          it 'should edit project' do
            expect {
              put :update, :id => project, :project => Factory.attributes_for(:project).merge({ :name => 'Updated name' })
            }.to change{ project.reload.name }.to('Updated name')
            response.should redirect_to(projects_path)
          end
        end

        describe "DELETE 'destroy'" do
          it 'should delete project' do
            expect {
              delete :destroy, :id => project
            }.to change(Project, :count).by(-1)
          end
        end
      end

      ["admin", "developer", "viewer"].each do |role_name|
        context "with #{role_name} role" do
          before { assign_member(project: project, member: user, role: role_name) }

          describe "GET 'show'" do
            before { get :show, :id => project }
            it { assigns(:project).should == project }
            it { response.should render_template('show') }
          end

          describe "GET 'index'" do
            before { get :index }
            it { assigns(:projects).should include(project) }
            it { response.should render_template('index') }
          end
        end
      end

      ["no", "developer", "viewer"].each do |role_name|
        context "with #{role_name} role" do
          before { assign_member(project: project, member: user, role: role_name) }

          it 'should not authorize' do
            should_not_authorize_for(
              -> { get :edit, :id => project.id },
              -> { put :update, :id => project.id },
              -> { delete :destroy, :id => project.id }
            )
          end
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { get :new },
        -> { get :index},
        -> { get :show, :id => project.id },
        -> { get :edit, :id => project.id },
        -> { put :update, :id => project.id },
        -> { post :create, :id => project.id },
        -> { delete :destroy, :id => project.id }
      )
    end
  end

end

