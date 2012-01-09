class Ticket < ActiveRecord::Base
  include SequenceNumber
  include TicketEstimation
  belongs_to :project
  belongs_to :user
  has_many :ticket_attachements

  TYPES = {:feature => 'feature', :bug => 'bug', :task => 'task'}

  validate :assignment_for_members
  validates :title, :project, :story, :points, :presence => true

  private
  def assignment_for_members
    if self.project.present? && self.user.present?
      unless self.project.at_least_developers.include?(self.user)
        errors.add(:user, 'must be project developer or admin')
      end
    end
  end
end
