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

$(=> new DynamicEstimation('.ticket .dynamic_estimation select'))