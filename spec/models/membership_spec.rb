require 'spec_helper'

describe Membership do
  it { should belong_to(:user) }
  it { should belong_to(:project) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:role) }

  it 'should create membership from user_email' do
    user = Factory(:user)
    Membership.create(:user_email => user.email, :role => "admin").user.should == user
  end

  it 'should not be valid when user_email is present, but blank' do
    Membership.new(:user_email => "", :role => "admin").should_not be_valid
  end

  describe 'nullify_assignments' do
    let!(:user) { Factory(:user) }
    let!(:project) { Factory(:project) }
    let!(:membership) { Factory(:membership, :role => 'developer', :user => user, :project => project) }
    let!(:ticket) { Factory(:ticket, :user => user, :project => project) }

    it 'should nullify tickets assignments' do
      expect {
        membership.destroy
      }.to change { ticket.reload.user_id }.to(nil)
    end

    context 'when additional membership exists' do
      before { Factory(:membership, :role => 'admin', :user => user, :project => project) }
      it 'should not nullify tickets assignments' do
        expect {
          membership.destroy
        }.to_not change { ticket.reload.user_id }
      end
    end
  end
end