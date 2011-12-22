require 'spec_helper'

describe ChatsController do
  let(:project) { Factory(:project) }
  let(:chat) { Factory(:chat, :project => project) }

  context 'when user is logged in' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    context 'when project and chat exist' do
      before { chat }

      context 'with role' do
        before { assign_member(project: project, member: user, role: "viewer") }

        it 'should assign project with chats included' do
          get :index
          assigns(:projects).map(&:chats).flatten.should include(chat)
          response.should render_template(:index)
        end

        it 'should display projects and chats by visibility' do
          Project.should_receive(:visible_for).with(user).and_return(user.projects)
          get :index
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { get :index }
      )
    end
  end
end
