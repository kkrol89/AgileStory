module ApplicationHelper
  include Websockets::MessageBroadcast

  def is_image?(object)
    object.attachement_content_type =~ /image/
  end

  def shorten_title(title, options)
    truncate(title, :length => options[:to], :separator => ' ')
  end
end
