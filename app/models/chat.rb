class Chat < ActiveRecord::Base
  belongs_to :project
  has_many :messages

  validates :title, :project, :presence => true
end
