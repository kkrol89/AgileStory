class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates :user, :project, :role, :presence => true
end
