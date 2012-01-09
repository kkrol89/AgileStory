require 'spec_helper'

describe Chat::ChatAttachementsController do
  let(:chat) { Factory(:chat) }

  context 'when user is logged in' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    context 'with no role' do
      it 'should not authorize' do
        should_not_authorize_for(
          -> { post :create, :chat_id => chat.id }
        )
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { post :create, :chat_id => chat.id }
      )
    end
  end
end