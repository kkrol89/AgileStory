class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates :user, :project, :role, :presence => true

  def admin?
    self.role == Role::ROLES[:admin]
  end

  def developer?
    self.role == Role::ROLES[:developer]
  end

  def viewer?
    self.role == Role::ROLES[:viewer]
  end
end
