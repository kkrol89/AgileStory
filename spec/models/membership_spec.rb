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
end