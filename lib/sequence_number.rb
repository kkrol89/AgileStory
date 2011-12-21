module SequenceNumber
  def self.included(klass)
    klass.instance_eval do
      before_validation :set_unique_sequence_number
      validate :uniqueness_of_number_within_project
      alias_attribute :number, :sequence_number
    end
  end

  private
  def set_unique_sequence_number
    if self.project.present? && self.sequence_number.blank?
      self.sequence_number = (self.class.where(:project_id => self.project_id).maximum(:sequence_number).to_i + 1)
    end
  end

  def uniqueness_of_number_within_project
    if self.project_id.present? && self.class.where(:project_id => self.project_id, :sequence_number => self.sequence_number).any?
      self.errors.add(:sequence_number, 'should be unique')
    end
  end
end