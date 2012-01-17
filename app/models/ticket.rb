class Ticket < ActiveRecord::Base
  include TicketEstimation
  include UpdateNotifications

  belongs_to :user
  belongs_to :board

  has_many :ticket_attachements

  acts_as_list :scope => :board

  TYPES = {:feature => 'feature', :bug => 'bug', :task => 'task'}
  STATES = {'open' => 'Open', 'in_progress' => 'In progress', 'finished' => 'Finished', 'accepted' => 'Accepted', 'rejected' => 'Rejected'}

  validate :assignment_for_members
  validate :assignment_required_for_start
  validates :title, :story, :points, :board, :presence => true

  state_machine :state, :initial => 'open' do
    event :start do
      transition ['open', 'rejected'] => 'in_progress'
    end

    event :finish do
      transition 'in_progress' => 'finished'
    end

    event :accept do
      transition 'finished' => 'accepted'
    end

    event :reject do
      transition 'finished' => 'rejected'
    end
  end

  def project
    board.try(:project)
  end

  def feature?
    story == TYPES[:feature]
  end

  def assigned_to?(user)
    self.user == user
  end

  private
  def assignment_for_members
    if self.project.present? && self.user.present?
      unless self.project.at_least_developers.include?(self.user)
        errors.add(:user, 'must be project developer or admin')
      end
    end
  end

  def assignment_required_for_start
    if self.state != 'open' && self.user.nil?
      errors.add(:state, 'can not be changed for not assigned ticket')
    end
  end
end
