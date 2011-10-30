require 'spec_helper'

describe User do
  it { should have_many(:projects) }
  it { should have_many(:memberships) }
  it { User.new(:email => 'user@example.org', :password => 'secret').should be_valid }

  describe 'is_admin_of?' do
    let(:user) { Factory(:user) }
    let(:project) { Factory(:project) }
    let(:other_project) { Factory(:project) }
    before { project.add_member(user, 'admin') }

    it 'should answer whether user is admin of given project' do
      user.is_admin_of?(project).should be_true
      user.is_admin_of?(other_project).should be_false
    end
  end
end

