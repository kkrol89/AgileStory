class FlashMessage
  constructor: (@selector) ->
    $(@selector + ' .hide_button a').click(=>
      $(@selector).fadeOut('fast')
      false
    )

$(=> new FlashMessage('.flash.notice'))
$(=> new FlashMessage('.flash.alert'))