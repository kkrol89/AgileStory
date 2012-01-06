class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project, :validate => true

  attr_accessor :user_email
  validate :user_email_presence
  
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

  private
  def user_email_presence
    unless user_email.nil?
      if user_email.present? && (user = User.find_by_email(user_email))
        self.user_id = user.id
      else
        errors.add(:user_email, "not found")
      end
    end
  end
end
