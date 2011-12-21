require 'spec_helper'

describe MembershipsController do

  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    let!(:project) { Factory(:project) }

    context 'with admin role' do
      before { assign_member(project: project, member: user, role: "admin") }

      describe "GET 'new'" do
        it 'should assign new membership' do
          get :new, :project_id => project
          assigns(:membership).should be_a_new(Membership)
          assigns(:project).should == project
        end
      end

      describe "POST 'create'" do
        it 'should create new membership' do
          expect {
            post :create, :project_id => project, :membership => Factory.build(:membership, :project_id => project.id).attributes
          }.to change { project.memberships.count }.by(1)
          response.should redirect_to(project_memberships_path(project))
        end
      end

      context "when membership exists" do
        let!(:membership) { Factory(:membership, :project => project, :role => User::ROLES[:developer]) }

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
              get :index, :project_id => project.id
              assigns(:memberships).should include(membership)
              assigns(:memberships).should_not include(another_membership)
            end
          end
        end

        describe "GET 'edit'" do
          it "should assign membership" do
            get :edit, :project_id => project.id, :id => membership.id
            assigns(:membership).should == membership
            response.should render_template('edit')
          end
        end

        describe "PUT 'update'" do
          it "should update membership role" do
            expect {
              put :update, :project_id => project.id, :id => membership.id, :membership => membership.attributes.merge({ :role => User::ROLES[:viewer] })
            }.to change { membership.reload.role }.to(User::ROLES[:viewer])
            response.should redirect_to(project_memberships_path(project))
          end
        end

        describe "DELETE 'destroy" do
          it 'should delete membership' do
            expect {
              delete :destroy, :project_id => project.id, :id => membership.id
            }.to change { project.memberships.count }.by(-1)
            response.should redirect_to(project_memberships_path(project))
          end
        end
      end
    end

    ["developer", "viewer"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        describe "GET 'index'" do
          before { get :index, :project_id => project }
          it { response.should be_success }
        end
      end
    end

    ["no", "developer", "viewer"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        describe "GET 'new'" do
          before { get :new, :project_id => project }
          it { response.should redirect_to(root_path) }
        end

        describe "POST 'create'" do
          it 'should not create new membership' do
            expect {
              post :create, :project_id => project, :membership => Factory.build(:membership, :project_id => project.id).attributes
            }.to_not change { project.memberships.count }
            response.should redirect_to(root_path)
          end
        end

        context "when membership exists" do
          let!(:membership) { Factory(:membership, :project => project) }

          describe "GET 'edit" do
            before { get :edit, :project_id => project, :id => membership.id }
            it { response.should redirect_to(root_path) }
          end

          describe "PUT 'update" do
            it 'should not update membership' do
              expect {
                put :update, :project_id => project, :id => membership.id, :membership => membership.attributes.merge({ :role => User::ROLES[:viewer] })
              }.to_not change { membership.reload.role }
              response.should redirect_to(root_path)
            end
          end

          describe "DELETE 'destroy" do
            it 'should not delete membership' do
              expect {
                delete :destroy, :project_id => project, :id => membership.id
              }.to_not change { project.memberships.count }
              response.should redirect_to(root_path)
            end
          end
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
