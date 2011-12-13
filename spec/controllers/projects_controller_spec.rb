require 'spec_helper'

describe ProjectsController do

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
        Project.last.memberships.where(:user_id => user, :role => Role::ROLES[:admin]).should_not be_empty
      end
    end

    context 'with existing project' do
      let!(:project) { Factory(:project) }

      context 'with admin role' do
        before { project.add_member(user, "admin") }

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

        describe "GET 'edit'" do
          before { get :edit, :id => project }
          it { assigns(:project).should == project }
          it { response.should render_template('edit') }
        end

        describe "PUT 'update'" do
          it 'should edit project' do
            expect {
              put :update, :id => project, :project => Factory.attributes_for(:project).merge({ :name => 'Updated name' })
            }.to change{ Project.first.name }.to('Updated name')
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

      ["developer", "viewer"].each do |role_name|
        context "with #{role_name} role" do
          before { project.add_member(user, role_name) }

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

          describe "GET 'edit'" do
            before { get :edit, :id => project }
            it { response.should redirect_to(root_path) }
          end

          describe "PUT 'update'" do
            before { put :update, :id => project, :project => Factory.attributes_for(:project).merge({ :name => 'Updated name' }) }
            it { response.should redirect_to(root_path) }
          end

          describe "DELETE 'destroy'" do
            before { delete :destroy, :id => project }
            it { response.should redirect_to(root_path) }
          end
        end
      end
    end
  end

  context 'when not logged in' do
    describe "GET 'new'" do
      before { get :new  }
      it { response.should redirect_to(new_user_session_path) }
    end

    describe "GET 'index'" do
      before { get :index }
      it { response.should redirect_to(new_user_session_path) }
    end

    describe "POST 'create'" do
      before { post :create, :project => Factory.attributes_for(:project) }
      it { response.should redirect_to(new_user_session_path) }
    end

    context 'with existing project' do
      let!(:project) { Factory(:project) }

      describe "GET 'show'" do
        before { get :show, :id => project }
        it { response.should redirect_to(new_user_session_path) }
      end

      describe "GET 'edit'" do
        before { get :edit, :id => project }
        it { response.should redirect_to(new_user_session_path) }
      end

      describe "PUT 'update'" do
        before { put :update, :id => project, :project => Factory.attributes_for(:project) }
        it { response.should redirect_to(new_user_session_path) }
      end

      describe "DELETE 'destroy'" do
        before { delete :destroy, :id => project }
        it { response.should redirect_to(new_user_session_path) }
      end
    end
  end

end

