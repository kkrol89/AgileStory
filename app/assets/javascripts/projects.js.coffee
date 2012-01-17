class Ticket
  constructor: (@ticket)->
  points: ->
    $(@ticket).find('select').val()
  hide_assign: ->
    $(@ticket).find('.action .assign').hide()
  id: ->
    $(@ticket).attr('data-ticket-id')
  fade: (value)->
    $(@ticket).parents('.board').fadeTo('fast', value)


class DynamicEstimation
  constructor: (@selector)->
    $(@selector).change((data)=> 
      @estimate(new Ticket($(data.target).parents('li.ticket')))
    )
  estimate: (ticket)->
    ticket.fade(0.5)
    $.ajax({
      type: "POST",
      url: '/tickets/' + ticket.id() + '/estimations',
      data: JSON.stringify({ estimation: ticket.points() }),
      contentType: 'application/json',
      dataType: 'json',
      success: (response)=>
        ticket.fade(1.0)
        if response.notice
          window.notice.message(response.notice)
        else if response.error
          window.alert.message(response.error)
    })

class UpdateNotifier
  constructor: (@project)->
    if @channel() && @key() && @channel().length > 0 && @key().length > 0
      @silence_notifications = 0
      pusher = new Pusher(@key())
      @channel = pusher.subscribe(@channel())
      @channel.bind('project_update', (data)=> @handler(data))
  handler: (data)=>
    unless @silence_notifications > 0
      window.update_notice.message(data)
      window.auto_refresh.refresh_message()
    else
      @silence_notifications--
  key: ->
    $(@project).attr('data-pusher-key')
  channel: ->
    $(@project).attr('data-channel-name')
  without_notify: ->
    @silence_notifications += 1

class AutoRefresh
  constructor: (@selector)->
    @auto_refresh = false
    @enable_button().click(=>
      @auto_refresh = true
      @enable_button().hide()
      @disable_button().show()
    )
    @disable_button().click(=>
      @auto_refresh = false
      @enable_button().show()
      @disable_button().hide()
    )
    @refresh_button().click(=>
      window.location.reload()
    )
  enable_button: ->
    $(@selector + ' .enable_auto_refresh')
  disable_button: ->
    $(@selector + ' .disable_auto_refresh')
  refresh_button: ->
    $(@selector + ' .manual_refresh')
  refresh_message: ->
    if @auto_refresh
      window.location.reload()
    else
      @refresh_button().show()

$(=> @auto_refresh = new AutoRefresh('.project_live_update'))
$(=> @update_notifier = new UpdateNotifier($('.project_live_update')))
$(=> new DynamicEstimation('.ticket .dynamic_estimation select'))