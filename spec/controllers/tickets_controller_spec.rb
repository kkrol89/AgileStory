require 'spec_helper'

describe TicketsController do
  let!(:project) { Factory(:project) }

  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }


    ["admin", "developer", "viewer"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        describe "GET 'new'" do
          before { get :new, :project_id => project.id }
          it { assigns(:ticket).should be_a_new(Ticket) }
          it { response.should render_template(:new) }
        end

        describe "POST 'create" do
          it 'should create new ticket' do
            expect {
              post :create, :project_id => project.id, :ticket => Factory.build(:ticket, :project => project).attributes
            }.to change { project.reload.tickets.count }.by(1)
            response.should redirect_to(project_path(project))
          end
        end
      end
    end

    context 'with no role' do
      describe "GET 'new'" do
        before { get :new, :project_id => project.id }
        it { response.should redirect_to(root_path) }
      end

      describe "POST 'create" do
        it 'should not create new ticket' do
          expect {
            post :create, :project_id => project.id, :ticket => Factory.build(:ticket, :project => project).attributes
          }.to_not change { project.reload.tickets.count }
          response.should redirect_to(root_path)
        end
      end
    end
  end

  context 'when not logged in' do
    describe "GET 'new'" do
      before { get :new, :project_id => project }
      it { response.should redirect_to(new_user_session_path) }
    end
    
    describe "POST 'create'" do
      before { get :create, :project_id => project, :ticket => Factory.build(:ticket, :project => project).attributes }
      it { response.should redirect_to(new_user_session_path) }
    end
  end
end
