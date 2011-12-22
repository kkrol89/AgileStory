require 'spec_helper'

describe Chat do
  it { should belong_to(:project) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:project) }
end
