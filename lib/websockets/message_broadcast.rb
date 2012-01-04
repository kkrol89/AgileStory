module Websockets
  module MessageBroadcast
    def broadcast(channel, event, &block)
      Websockets::PusherSender.new.send(:channel => channel, :event => event, :message => capture(&block))
    end
  end
end