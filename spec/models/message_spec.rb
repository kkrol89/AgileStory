require 'spec_helper'

describe Message do
  it { should belong_to(:chat) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:chat) }
  it { should validate_presence_of(:user) }
end
