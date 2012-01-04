module ChatsHelper
  def is_image?(chat_attachement)
    chat_attachement.attachement_content_type =~ /image/
  end
end