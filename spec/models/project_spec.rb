require 'spec_helper'

describe Project do
  let(:project) { Factory(:project) }
  let(:user) { Factory(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should have_many(:users) }
  it { should have_many(:memberships) }
  it { should have_many(:sprints) }
  it { should have_many(:tickets) }
  it { should have_many(:chats) }
  
  context "with one project already created" do
    before { Factory(:project) }
    it { should validate_uniqueness_of(:name) }
  end
  
  describe "add_member" do
    
    it 'should create membership' do
      project.add_member(user, User::ROLES[:admin])
      project.memberships.where(:user_id => user).first.role.should eq(User::ROLES[:admin])
      project.users.where(:id => user).first.should eq(user)
      user.projects.where(:id => project).first.should eq(project)
    end
  end

  describe 'visible for' do
    ["admin", "developer", "viewer"].each do |role_name|
      context "with #{role_name}" do
        before { assign_member(project: project, member: user, role: role_name) }

        it 'should include project' do
          Project.visible_for(user).should include(project)
        end
      end
    end
  end

  context 'with no role' do
    it 'should not include project' do
      Project.visible_for(user).should_not include(project)
    end
  end
end

