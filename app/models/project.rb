class Project < ActiveRecord::Base
  belongs_to(:user)

  validates :name, :description, :user, :presence => true
  validates :name, :uniqueness => true
end

