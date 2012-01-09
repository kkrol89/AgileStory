require 'spec_helper'

describe Ticket::TicketAttachementsController do
  let(:ticket) { Factory(:ticket) }

  context 'when user is logged in' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    ["no", "viewer"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: ticket.project, member: user, role: role_name) }

        it 'should not authorize' do
          should_not_authorize_for(
            -> { post :create, :ticket_id => ticket.id }
          )
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require login' do
      should_require_login_for(
        -> { post :create, :ticket_id => ticket.id }
      )
    end
  end
end
