class Chat < ActiveRecord::Base
  belongs_to :project

  validates :title, :project, :presence => true
end
