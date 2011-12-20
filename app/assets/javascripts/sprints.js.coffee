class SprintDateCalendar
  constructor: (@selector) ->
    $(@selector).datepicker({
      minDate: 0,
      dateFormat: 'dd-mm-yy'
    })

$(=> new SprintDateCalendar('#sprint_start_date'))