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
            }.to change { project.tickets.count }.by(1)
            response.should redirect_to(project_path(project))
          end
        end
      end
    end

    context 'with no role' do
      it 'should not authorize' do
        should_not_authorize_for(
          -> { get :new, :project_id => project.id },
          -> { post :create, :project_id => project.id }
        )
      end
    end
  end

  context 'when not logged in' do
    it 'should require_login' do
      should_require_login_for(
        -> { get :new, :project_id => project.id },
        -> { post :create, :project_id => project.id }
      )
    end
  end
end
