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
    context 'with no role' do
      it 'should not include project' do
        Project.visible_for(user).should_not include(project)
      end
    end
  end

  describe 'at_least_developers' do
    let!(:admin) { Factory(:membership, :project => project, :role => 'admin').user }
    let!(:developer) { Factory(:membership, :project => project, :role => 'developer').user }
    let!(:viewer) { Factory(:membership, :project => project, :role => 'viewer').user }

    it 'should include only admin and developer' do
      members = project.at_least_developers
      members.should include(admin)
      members.should include(developer)
      members.should_not include(viewer)
    end
  end

  describe 'project create' do
    it 'should create icebox' do
      expect {
        project = Factory(:project)
      }.to change(Icebox, :count).by(1)
      project.icebox.should be_a(Icebox)
    end

    it 'should create backlog' do
      expect {
        project = Factory(:project)
      }.to change(Backlog, :count).by(1)
      project.backlog.should be_a(Backlog)
    end
  end
end

