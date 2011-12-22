module Messages
  def web_broadcast(options)
    PusherSender.new(options) unless Rails.env? 'test'
  end
end