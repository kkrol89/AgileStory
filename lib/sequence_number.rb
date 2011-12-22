module SequenceNumber
  def self.included(klass)
    klass.instance_eval do
      before_validation :set_unique_sequence_number
      validates :sequence_number, :uniqueness => { :scope => :project_id }
      alias_attribute :number, :sequence_number
    end
  end

  private
  def set_unique_sequence_number
    if self.project.present? && self.sequence_number.blank?
      self.sequence_number = (self.class.where(:project_id => self.project_id).maximum(:sequence_number).to_i + 1)
    end
  end
end