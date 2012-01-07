require 'spec_helper'

describe Ticket do
  it { should belong_to(:project) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:story) }

  describe 'ticket number uniqueness' do
    context 'when project exists' do
      let!(:project) { Factory(:project) }

      context 'when ticket number is already taken within project' do
        before { Factory(:ticket, :project => project, :sequence_number => 1) }
        it { Factory.build(:ticket, :project => project, :sequence_number => 1).should_not be_valid }

        it 'should create unique ticket number' do
          Factory(:ticket, :project => project).sequence_number.should == 2
        end
      end
    end
  end
end
