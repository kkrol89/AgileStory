class Project < ActiveRecord::Base
  has_many :sprints
  has_many :memberships
  has_many :tickets
  has_many :users, :through => :memberships

  validates :name, :description, :presence => true
  validates :name, :uniqueness => true

  validate :at_least_one_admin

  accepts_nested_attributes_for :memberships
  before_save :notify_about_change

  def add_member(user, role)
    self.memberships << Membership.new(:project => self, :user => user, :role => role)
  end

  def self.visible_for(user)
    self.joins(:memberships).where('memberships.user_id = ?', user.id)
  end

  private
  def at_least_one_admin
    unless self.memberships.any? { |membership| membership.role == User::ROLES[:admin] }
      errors.add(:memberships, 'should include at least one admin')
    end
  end
  def notify_about_change
    Websockets::PusherSender.new.send(:channel => 'projects', :event => 'project save', :message => 'project saved')
  end
end

