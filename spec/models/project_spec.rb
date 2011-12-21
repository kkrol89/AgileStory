require 'spec_helper'

describe Project do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should have_many(:users) }
  it { should have_many(:memberships) }
  it { should have_many(:sprints) }
  it { should have_many(:tickets) }
  
  context "with one project already created"do
    before { Factory(:project) }
    it { should validate_uniqueness_of(:name) }
  end
  
  describe "add_member" do
    let(:user) { Factory(:user) }
    let(:project) { Factory(:project) }
    
    it 'should create membership' do
      project.add_member(user, User::ROLES[:admin])
      project.memberships.where(:user_id => user).first.role.should eq(User::ROLES[:admin])
      project.users.where(:id => user).first.should eq(user)
      user.projects.where(:id => project).first.should eq(project)
    end
  end
end

