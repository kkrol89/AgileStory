class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validate :user, :project, :role, :presence => true
end
