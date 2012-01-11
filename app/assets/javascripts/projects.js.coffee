class Ticket
  constructor: (@ticket)->
  points: ->
    $(@ticket).find('select').val()
  hide_assign: ->
    $(@ticket).find('.action .assign').hide()
  id: ->
    $(@ticket).attr('data-ticket-id')


class DynamicEstimation
  constructor: (@selector)->
    $(@selector).change((data)=> 
      @estimate(new Ticket($(data.target).parents('li.ticket')))
    )
  estimate: (ticket)->
    $.ajax({
      type: "POST",
      url: '/tickets/' + ticket.id() + '/estimations',
      data: JSON.stringify({ estimation: ticket.points() }),
      contentType: 'application/json',
      dataType: 'json',
      success: (response)=>
        if response.notice
          window.notice.message(response.notice)
        else if response.error
          window.alert.message(response.error)
    })

$(=> new DynamicEstimation('.ticket .dynamic_estimation select'))