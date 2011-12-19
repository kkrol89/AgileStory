class Sprint < ActiveRecord::Base
  belongs_to :project

  validates :project, :start_date, :duration, :number, :presence => true
  validate :uniqueness_of_number_within_project

  before_validation :set_unique_number

  def name
    "Sprint #{number}" if self.number.present?
  end

  private
  def set_unique_number
    if self.project.present? && self.number.blank?
      self.number = (Sprint.where(:project_id => self.project_id).maximum(:number).to_i + 1)
    end
  end

  def uniqueness_of_number_within_project
    if self.project_id.present? && Sprint.where(:project_id => self.project_id, :number => self.number).any?
      self.errors.add(:number, 'should be unique')
    end
  end
end
