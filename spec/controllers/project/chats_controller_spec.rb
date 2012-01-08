require 'spec_helper'

describe Project::ChatsController do
  let(:project) { Factory(:project) }
  let(:chat) { Factory(:chat, :project => project) }

  context 'when user is logged in' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    context 'when project exists' do
      before { project }

      context 'with admin role' do
        before { assign_member(project: project, member: user, role: "admin") }
        describe "GET 'new'" do
          before { get :new, :project_id => project.id }

          it 'should assign new chat' do
            assigns(:chat).should be_a_new(Chat)
            response.should render_template(:new)
          end
        end

        describe "POST 'create'" do
          it 'should create one chat' do
            expect {
              post :create, :project_id => project.id, :chat => Factory.attributes_for(:chat)
            }.to change { project.chats.count }.by(1)
            response.should redirect_to(project_chats_path(project))
          end
        end

        describe "DELETE 'destroy'" do
          before { chat }
          it 'should destroy chat' do
            expect {
              delete :destroy, :project_id => project.id, :id => chat.id
            }.to change { project.chats.count }.by(-1)
          end
        end
      end

      ["admin", "developer", "viewer"].each do |role_name|
        context "with #{role_name} role" do
          before { assign_member(project: project, member: user, role: role_name) }
          context 'when chat and messages exists' do
            before { chat }

            describe "GET 'show'" do
              before { get :show, :project_id => project.id, :id => chat.id }
              it { assigns(:chat).should == chat }
            end

            describe "GET 'index'" do
              before { get :index, :project_id => project.id }
              it { assigns(:chats).should include(chat) }
            end
          end
        end
      end

      ["no", "developer", "viewer"].each do |role_name|
        context "with #{role_name} role" do
          before { assign_member(project: project, member: user, role: role_name) }
          it 'should not authorize' do
            should_not_authorize_for(
              -> { get :new, :project_id => project.id },
              -> { post :create, :project_id => project.id },
              -> { delete :destroy, :project_id => project.id, :id => chat.id }
            )
          end
        end
      end

      context "with no role" do
        it 'should not authorize' do
          should_not_authorize_for(
            -> { get :show, :project_id => project.id, :id => chat.id },
            -> { get :index, :project_id => project.id }
          )
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { get :new, :project_id => project.id },
        -> { post :create, :project_id => project.id },
        -> { get :show, :project_id => project.id, :id => chat.id },
        -> { get :index, :project_id => project.id },
        -> { delete :destroy, :project_id => project.id, :id => chat.id }
      )
    end
  end
end
