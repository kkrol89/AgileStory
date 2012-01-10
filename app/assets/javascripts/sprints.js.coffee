class SprintDateCalendar
  constructor: (@selector) ->
    $(@selector).datepicker({
      minDate: 0,
      dateFormat: 'dd-mm-yy'
    })

class SprintSwitcher
  constructor: (@selector) ->
    @switch().change(=>
      window.location = @project_url() + '?sprint_id=' + @switch().val()
    )
  switch: ->
    $(@selector + ' select')
  project_url: ->
    $(@selector).attr('project-url')

$(=> new SprintDateCalendar('#sprint_start_date'))
$(=> new SprintSwitcher('.sprint .management .switch'))