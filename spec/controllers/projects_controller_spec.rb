require 'spec_helper'

describe ProjectsController do

  context 'when logged in as user' do
    before { sign_in Factory(:user) }
    describe "GET 'new'" do
      before { get :new }
      it { assigns(:project).should be_a_new(Project) }
      it { response.should render_template('new') }
    end

    describe "POST 'create'" do
      context 'with valid attributes' do
        it 'should create one project' do
          expect {
            post :create, :project => Factory.attributes_for(:project)
          }.to change(Project, :count).by(1)
          response.should redirect_to(projects_path)
        end
      end

      context 'with invalid attributes' do
        it 'should not create any projects' do
          expect {
            post :create, :project => {}
          }.to_not change(Project, :count)
          response.should render_template('new')
        end
      end
    end

    context 'with existing project' do
      let!(:project) { Factory(:project) }

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
        context 'with valid attributes' do
          it 'should edit project' do
            expect {
              put :update, :id => project, :project => Factory.attributes_for(:project).merge({ :name => 'Updated name' })
            }.to change{ Project.first.name }.to('Updated name')
            response.should redirect_to(projects_path)
          end
        end

        context 'with invalid attributes' do
          it 'should not edit project' do
            expect {
              post :update, :id => project, :project => Factory.attributes_for(:project).merge({ :name => '' })
            }.to_not change{ Project.first.name }
            response.should render_template('edit')
          end
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

