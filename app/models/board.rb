class Board < ActiveRecord::Base
  belongs_to :project
  has_many :tickets, :order => :position
  validates :project, :presence => true

  def sprint?
    self.type == 'Sprint'
  end
end
