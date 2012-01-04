require 'spec_helper'

describe ChatAttachement do
  it { should belong_to(:chat) }
  it { should belong_to(:user) }
end
