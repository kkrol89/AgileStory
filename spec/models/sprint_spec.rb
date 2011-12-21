require 'spec_helper'

describe Sprint do
  it { should belong_to(:project) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:start_date) }

  describe 'sprint number uniqueness' do
    context 'when project exists' do
      let!(:project) { Factory(:project) }

      context 'when sprint number is already taken within project' do
        before { Factory(:sprint, :project => project, :sequence_number => 1) }
        it { Factory.build(:sprint, :project => project, :sequence_number => 1).should_not be_valid }

        it 'should create unique sprint number' do
          Factory(:sprint, :project => project).sequence_number.should == 2
        end
      end
    end
  end
end
