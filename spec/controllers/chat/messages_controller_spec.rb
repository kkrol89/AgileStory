require 'spec_helper'

describe Chat::MessagesController do
  let(:user) { Factory(:user) }
  let(:project) { Factory(:project) }
  let(:chat) { Factory(:chat, :project => project)}

  context 'when project and chat exsits' do
    before { project }
    before { chat }
    context 'when logged in' do
      before { sign_in user }

      ["admin", "developer", "viewer"].each do |role_name|
        context "with #{role_name} role" do
          before { assign_member(project: project, member: user, role: role_name) }
          
          describe "POST 'create'" do
            it 'should create new message' do
              expect {
                post :create, :chat_id => chat.id, :message => Factory.attributes_for(:message), :format => :js
              }.to change{ chat.messages.count }.by(1)
            end
          end
        end
      end

      context 'with no role' do
        describe "POST 'create'" do
          it 'should not authorize' do
            should_not_authorize_for(
              -> { post :create, :chat_id => chat.id, :format => :js }
            )
          end
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { post :create, :chat_id => chat.id, :format => :js }
      )
    end
  end
end
