class PusherListener
  constructor: (@channel, @event, @key, @event_handler)->
    pusher = new Pusher(@key)
    channel = pusher.subscribe(@channel)
    channel.bind(@event, (data)=> @event_handler(data))

class Chat
  constructor: (@chat)->
    $(@chat + " .messages").animate({ scrollTop: $(@chat + ' .messages').height() }, "slow");
    $(@chat + " .chat_attachements").animate({ scrollTop: $(@chat + ' .chat_attachements').height() }, "slow");
    if $(@chat) && $(@chat).attr('data-pusher-key')
      new PusherListener('messages_new', 'message_created', $(@chat).attr('data-pusher-key'), @handle_websocket_event)
      new PusherListener('chat_attachements_new', 'chat_attachement_created', $(@chat).attr('data-pusher-key'), @handle_websocket_event)
  handle_websocket_event: (data)->
    eval(data)

$(=> @chat = new Chat('.chat_window'))