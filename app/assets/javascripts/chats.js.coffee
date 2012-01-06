class ChatNotification
  constructor: (@key, @channel)->
    pusher = new Pusher(@key)
    @channel = pusher.subscribe(@channel)
  notification: (event, handler)->
    @channel.bind(event, (data)=> handler(data))

class Chat
  constructor: (@chat)->
    $(@chat + " .messages").animate({ scrollTop: $(@chat + ' .messages')[0].scrollHeight }, "slow");
    $(@chat + " .chat_attachements").animate({ scrollTop: $(@chat + ' .chat_attachements')[0].scrollHeight }, "slow");
    if $(@chat) && @pusher_key() && @channel_name()
      @chat_notification = new ChatNotification(@pusher_key(), @channel_name())
      @chat_notification.notification('message_created', @handle_websocket_event)
      @chat_notification.notification('chat_attachement_created', @handle_websocket_event)
  handle_websocket_event: (data)->
    eval(data)
  pusher_key: ->
    $(@chat).attr('data-pusher-key')
  channel_name: ->
    $(@chat).attr('data-chat-channel-name')
  

$(=> @chat = new Chat('.chat_window'))