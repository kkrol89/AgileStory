class FlashMessage
  constructor: (@selector) ->
    $(@selector + ' .hide_button a').click(=>
      $(@selector).fadeOut('fast')
      false
    )
  message: (message)->
    $(@selector + ' .message').html(message)
    $(@selector).fadeIn('fast')

$(=> @notice = new FlashMessage('.flash.notice'))
$(=> @alert = new FlashMessage('.flash.alert'))