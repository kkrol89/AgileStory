class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates :user, :project, :role, :presence => true

  def admin?
    self.role == User::ROLES[:admin]
  end

  def developer?
    self.role == User::ROLES[:developer]
  end

  def viewer?
    self.role == User::ROLES[:viewer]
  end
end
