class Project < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships

  validates :name, :description, :presence => true
  validates :name, :uniqueness => true
  
  validate :at_least_one_admin
  
  def add_member(user, role)
    self.memberships << Membership.new(:user => user, :role => role)
#    if self.new_record?
#      self.memberships.build(:user => user, :role => role)
#    else
#      self.memberships.create!(:user => user, :role => role)
#    end
  end

  private
  def at_least_one_admin
    unless self.memberships.any? { |membership| membership.role == Role::ROLES[:admin] }
      errors.add(:memberships, 'should include at least one admin')
    end
  end
end

