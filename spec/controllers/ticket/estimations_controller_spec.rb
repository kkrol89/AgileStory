require 'spec_helper'

describe Ticket::EstimationsController do
  let(:ticket) { Factory(:ticket, :points => '0') }
  let(:project) { ticket.project }

  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    ["admin", "developer"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        describe "POST 'create'" do
          it 'should update ticket points' do
            expect {
              post :create, :ticket_id => ticket.id, :estimation => '1', :format => :json
            }.to change { ticket.reload.points }.to(1)
          end
        end
      end
    end

    ["viewer", "no"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        describe "POST 'create'" do
          it 'should not authorize' do
            should_not_authorize_for(
              -> { post :create, :ticket_id => ticket.id }
            )
          end
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require_login' do
      should_require_login_for(
        -> { post :create, :ticket_id => ticket.id }
      )
    end
  end
end
