module ApplicationHelper
  def broadcast(channel, event, &block)
    Websockets::PusherSender.new.send(:channel => channel, :event => event, :message => capture(&block))
  end
end
