class Estimation
  constructor: (@estimation)->
  points: ->
    $(@estimation).children('select').val()
  ticket: ->
    $(@estimation).attr('data-ticket-id')


class DynamicEstimation
  constructor: (@selector)->
    $(@selector).change((data)=> 
      @estimate(new Estimation($(data.target).parent('.dynamic_estimation')))
    )
  estimate: (estimation)->
    $.ajax({
      type: "POST",
      url: '/tickets/' + estimation.ticket() + '/estimations',
      data: JSON.stringify({ estimation: estimation.points() }),
      contentType: 'application/json',
      dataType: 'json',
      success: (response)=>
        if response.notice
          window.notice.message(response.notice)
        else if response.error
          window.alert.message(response.error)
    })

$(=> new DynamicEstimation('.ticket .dynamic_estimation select'))