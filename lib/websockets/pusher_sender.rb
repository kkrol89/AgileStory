module Websockets
  class PusherSender
    def send(options)
      Pusher[options[:channel]].trigger(options[:event], options[:message])
    end
  end
end