class Project < ActiveRecord::Base
  has_many :boards, :dependent => :destroy
  has_many :sprints
  has_one :icebox
  has_one :backlog

  has_many :memberships, :dependent => :destroy
  has_many :tickets, :through => :boards, :dependent => :destroy
  has_many :chats, :dependent => :destroy
  has_many :users, :through => :memberships

  validates :name, :description, :point_scale, :presence => true
  validates :name, :uniqueness => true

  validate :at_least_one_admin

  accepts_nested_attributes_for :memberships

  after_create :create_icebox
  after_create :create_backlog

  POINT_SCALES = {:linear => 'linear', :fibonacci => 'fibonacci', :power => 'power'}

  def self.visible_for(user)
    user.projects
  end

  def add_member(user, role)
    self.memberships << Membership.new(:project => self, :user => user, :role => role)
  end

  def at_least_developers
    self.users
      .where("memberships.role = ? OR memberships.role = ?", User::ROLES[:admin], User::ROLES[:developer])
      .order('users.email')
  end

  private
  def at_least_one_admin
    unless self.memberships.any? { |membership| membership.role == User::ROLES[:admin] }
      errors.add(:memberships, 'should include at least one admin')
    end
  end

  def create_icebox
    Icebox.create!(:project => self)
  end

  def create_backlog
    Backlog.create!(:project => self)
  end
end

