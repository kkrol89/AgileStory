class FlashMessage
  constructor: (@selector) ->
    $(@selector + ' .hide_button a').click(=>
      $(@selector).hide()
      false
    )

$(=> new FlashMessage('.flash.notice'))
$(=> new FlashMessage('.flash.alert'))