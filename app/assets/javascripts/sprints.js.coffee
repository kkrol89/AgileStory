class SprintDateCalendar
  constructor: (@selector) ->
    $(@selector).datepicker();

$(=> new SprintDateCalendar('#sprint_start_date'))