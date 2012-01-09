class TicketAttachement < ActiveRecord::Base
  belongs_to :ticket
  has_attached_file :attachement
  validates_attachment_presence :attachement
end
