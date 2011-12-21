class Ticket < ActiveRecord::Base
  include SequenceNumber
  belongs_to :project

  validates :title, :project, :presence => true
end
