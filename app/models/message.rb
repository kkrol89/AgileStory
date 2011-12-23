class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :chat, :user, :presence => true
end
