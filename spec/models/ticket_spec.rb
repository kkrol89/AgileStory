require 'spec_helper'

describe Ticket do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:story) }
  it { should have_many(:ticket_attachements) }

  context 'when project exists' do
    let!(:project) { Factory(:project) }

    describe 'estimation' do
      ['bug', 'task'].each do |story|
        it "should not allow to set points for #{story}" do
          Factory.build(:ticket, :board => project.icebox, :story => story, :points => 1).should_not be_valid
        end
      end
      context 'when project has linear scale' do
        before { project.update_attribute(:point_scale, 'linear') }
        it 'should accept linear scale points' do
          Factory.build(:ticket, :board => project.icebox, :points => 7).should be_valid
          Factory.build(:ticket, :board => project.icebox, :points => 13).should_not be_valid
          Factory.build(:ticket, :board => project.icebox, :points => 32).should_not be_valid
        end
      end

      context 'when project has fibonacci scale' do
        before { project.update_attribute(:point_scale, 'fibonacci') }
        it 'should accept fibonacci scale points' do
          Factory.build(:ticket, :board => project.icebox, :points => 7).should_not be_valid
          Factory.build(:ticket, :board => project.icebox, :points => 13).should be_valid
          Factory.build(:ticket, :board => project.icebox, :points => 32).should_not be_valid
        end
      end

      context 'when project has power scale' do
        before { project.update_attribute(:point_scale, 'power') }
        it 'should accept power scale points' do
          Factory.build(:ticket, :board => project.icebox, :points => 7).should_not be_valid
          Factory.build(:ticket, :board => project.icebox, :points => 13).should_not be_valid
          Factory.build(:ticket, :board => project.icebox, :points => 32).should be_valid
        end
      end
    end

    describe 'state change validation' do
      it 'should not allow to change state of not assigned ticket' do
        Factory.build(:ticket, :user => nil, :state => 'in_progress').should_not be_valid
        Factory.build(:ticket, :user => nil).start.should be_false
      end
    end
  end
end
