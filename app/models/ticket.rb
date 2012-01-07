class Ticket < ActiveRecord::Base
  include SequenceNumber
  belongs_to :project

  TYPES = {:feature => 'feature', :bug => 'bug', :task => 'task'}

  validates :title, :project, :story, :presence => true
end
