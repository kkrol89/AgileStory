require 'spec_helper'

describe User do
  it { User.new(:email => 'user@example.org', :password => 'secret').should be_valid }
end

