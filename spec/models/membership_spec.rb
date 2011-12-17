require 'spec_helper'

describe Membership do
  it { should belong_to(:user) }
  it { should belong_to(:project) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:role) }
end