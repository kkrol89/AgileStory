class Ticket < ActiveRecord::Base
  include TicketEstimation

  belongs_to :user
  belongs_to :board

  has_many :ticket_attachements

  acts_as_list :scope => :board

  TYPES = {:feature => 'feature', :bug => 'bug', :task => 'task'}

  validate :assignment_for_members
  validates :title, :story, :points, :board, :presence => true

  def project
    board.try(:project)
  end

  def feature?
    story == TYPES[:feature]
  end

  private
  def assignment_for_members
    if self.project.present? && self.user.present?
      unless self.project.at_least_developers.include?(self.user)
        errors.add(:user, 'must be project developer or admin')
      end
    end
  end
end
