require 'spec_helper'

describe Board::TicketsController do
  let(:project) { Factory(:project) }
  let(:icebox) { project.icebox }
  let(:ticket) { Factory(:ticket, :board => icebox, :position => 1) }
  let(:ticket2) { Factory(:ticket, :board => icebox, :position => 2) }

  context 'when logged in as user' do
    let(:user) { Factory(:user) }
    before { sign_in user }

    ["admin", "developer"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        describe "POST 'sort'" do
          it 'should update ticket positions' do
            expect {
              expect {
                post :sort, :board_id => icebox.id, :tickets => [ticket2.id, ticket.id], :format => :json
              }.to change { ticket.reload.position }.to(2)
            }.to change { ticket2.reload.position }.to(1)
          end

          context 'when ticket belongs to another board' do
            let(:backlog_ticket) { Factory(:ticket, :board => project.backlog) }
            it 'should move it to current board' do
              expect {
                post :sort, :board_id => icebox.id, :tickets => [backlog_ticket.id], :format => :json
              }.to change { backlog_ticket.reload.board_id }.to (icebox.id)
            end
          end
        end
      end
    end

    ["viewer", "no"].each do |role_name|
      context "with #{role_name} role" do
        before { assign_member(project: project, member: user, role: role_name) }

        describe "POST 'sort'" do
          it 'should not authorize' do
            should_not_authorize_for(
              -> { post :sort, :board_id => icebox.id, :format => :json }
            )
          end
        end
      end
    end
  end

  context 'when not logged in' do
    it 'should require_login' do
      should_require_login_for(
        -> { post :sort, :board_id => icebox.id, :format => :json }
      )
    end
  end
end
