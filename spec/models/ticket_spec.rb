require 'spec_helper'

describe Ticket do
  it { should belong_to(:project) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:story) }
  it { should have_many(:ticket_attachements) }

  context 'when project exists' do
    let!(:project) { Factory(:project) }
    describe 'ticket number uniqueness' do

      context 'when ticket number is already taken within project' do
        before { Factory(:ticket, :project => project, :sequence_number => 1) }
        it { Factory.build(:ticket, :project => project, :sequence_number => 1).should_not be_valid }

        it 'should create unique ticket number' do
          Factory(:ticket, :project => project).sequence_number.should == 2
        end
      end
    end

    describe 'estimation' do
      ['bug', 'task'].each do |story|
        it "should not allow to set points for #{story}" do
          Factory.build(:ticket, :project => project, :story => story, :points => 1).should_not be_valid
        end
      end
      context 'when project has linear scale' do
        before { project.update_attribute(:point_scale, 'linear') }
        it 'should accept linear scale points' do
          Factory.build(:ticket, :project => project, :points => 7).should be_valid
          Factory.build(:ticket, :project => project, :points => 13).should_not be_valid
          Factory.build(:ticket, :project => project, :points => 32).should_not be_valid
        end
      end

      context 'when project has fibonacci scale' do
        before { project.update_attribute(:point_scale, 'fibonacci') }
        it 'should accept fibonacci scale points' do
          Factory.build(:ticket, :project => project, :points => 7).should_not be_valid
          Factory.build(:ticket, :project => project, :points => 13).should be_valid
          Factory.build(:ticket, :project => project, :points => 32).should_not be_valid
        end
      end

      context 'when project has power scale' do
        before { project.update_attribute(:point_scale, 'power') }
        it 'should accept power scale points' do
          Factory.build(:ticket, :project => project, :points => 7).should_not be_valid
          Factory.build(:ticket, :project => project, :points => 13).should_not be_valid
          Factory.build(:ticket, :project => project, :points => 32).should be_valid
        end
      end
    end
  end
end
