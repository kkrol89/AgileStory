require 'spec_helper'

describe Project do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }
  context "with one project already created"do
    before { Factory(:project) }
    it { should validate_uniqueness_of(:name) }
  end
end

