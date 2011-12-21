class Sprint < ActiveRecord::Base
  include SequenceNumber

  belongs_to :project
  validates :project, :start_date, :duration, :sequence_number, :presence => true

  def name
    "Sprint #{sequence_number}" if self.sequence_number.present?
  end
end
