require 'spec_helper'

describe User do
  it { should have_many(:projects) }
  it { should have_many(:memberships) }
  it { User.new(:email => 'user@example.org', :password => 'secret').should be_valid }
end

