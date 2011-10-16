require 'spec_helper'

describe ProjectsController do

  context 'when logged in as user' do
    before { sign_in Factory(:user) }
    describe "GET 'new'" do
      before { get :new }
      it { assigns(:project).should be_a_new(Project) }
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
        end
      end
    end

    describe "GET 'index'" do
      let!(:project) { Factory(:project) }
      before { get :index }
      it { assigns(:projects).should include(project) }
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
  end

end

