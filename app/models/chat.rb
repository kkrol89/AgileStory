class Chat < ActiveRecord::Base
  belongs_to :project
  has_many :messages
  has_many :chat_attachements

  validates :title, :project, :presence => true
end
