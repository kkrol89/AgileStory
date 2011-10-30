class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :memberships
  has_many :projects, :through => :memberships

  def is_admin_of?(project)
    Membership.where(:user_id => self, :project_id => project, :role => Role::ROLES[:admin]).any?
  end
end

