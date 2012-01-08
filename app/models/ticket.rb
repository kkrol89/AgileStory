class Ticket < ActiveRecord::Base
  include SequenceNumber
  include TicketEstimation
  belongs_to :project

  TYPES = {:feature => 'feature', :bug => 'bug', :task => 'task'}

  validates :title, :project, :story, :points, :presence => true
end
