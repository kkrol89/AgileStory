class ChatAttachement < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user
  has_attached_file :attachement
  validates_attachment_presence :attachement
end
