class Project < ActiveRecord::Base
  has_many :sprints
  has_many :memberships
  has_many :tickets
  has_many :chats
  has_many :users, :through => :memberships

  validates :name, :description, :presence => true
  validates :name, :uniqueness => true

  validate :at_least_one_admin

  accepts_nested_attributes_for :memberships

  def add_member(user, role)
    self.memberships << Membership.new(:project => self, :user => user, :role => role)
  end

  def self.visible_for(user)
    user.projects
  end

  private
  def at_least_one_admin
    unless self.memberships.any? { |membership| membership.role == User::ROLES[:admin] }
      errors.add(:memberships, 'should include at least one admin')
    end
  end
end

