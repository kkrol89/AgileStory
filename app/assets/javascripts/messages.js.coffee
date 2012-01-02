class Chat
  constructor: (@chat)->
    if $(@chat) && $(@chat).attr('data-pusher-key')
      pusher = new Pusher($(@chat).attr('data-pusher-key'))
      channel = pusher.subscribe('messages_new')
      channel.bind('message_created', (data)=>
        @message_created(data)
      )
  message_created: (data)->
    eval(data)

$(=> @chat = new Chat('.chat_window'))