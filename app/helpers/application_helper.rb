module ApplicationHelper
  include Websockets::MessageBroadcast

  def is_image?(object)
    object.attachement_content_type =~ /image/
  end
end
