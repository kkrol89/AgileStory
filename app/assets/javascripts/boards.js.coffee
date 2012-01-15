class BoardUpdate
  constructor: (@board) ->
    @board.fade(0.5)

    $.ajax({
      type: "POST",
      url: '/boards/' + @board.board_id() + '/tickets/sort',
      data: JSON.stringify({ tickets: @board.tickets_ids() }),
      contentType: 'application/json',
      dataType: 'json',
      success: (response)=>
        @board.fade(1.0)
        if response.notice
          window.notice.message(response.notice)
        else if response.error
          window.alert.message(response.error)
    })

class Board
  constructor: (@board) ->
  fade: (value)->
    $(@board).fadeTo('fast', value)
  board_id: ->
    $(@board).attr('data-board-id')
  tickets: ->
    $(@board).children('.tickets').children('ol').children('li')
  tickets_ids: ->
    $.map(@tickets(), (ticket)->
      parseInt $(ticket).attr('data-ticket-id')
    )

class BoardManager
  constructor: (@selector) ->
    @tickets_list().sortable({
      placeholder: 'sortable-placeholder',
      connectWith: @tickets_list(),
      update: -> new BoardUpdate(new Board($(this).parents('.board')))
    })
    @tickets_list().droppable({
      over: -> $(this).parents('.board').addClass('highlighted')
      out: -> $(this).parents('.board').removeClass('highlighted')
      drop: -> $(this).parents('.board').removeClass('highlighted')
    })
  tickets_list: ->
    $(@selector + ' .tickets ol')

$(=> new BoardManager('.boards .board.managed'))