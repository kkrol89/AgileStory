module Messages
  def web_broadcast(options)
    PusherSender.new(options)
  end
end