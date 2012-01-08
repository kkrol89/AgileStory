class ScenarioOutline
  build: ->
    'Feature: Feature name\nIn order to\nAs a\nI want to\n\nScenario:\n'

class CucumberSyntax
  constructor: (@text)->
  highlight: ->
    @text = @text.replace(/((Feature:|In order to|As a|I want)[^\n]*)/gi, "<pre class='keyword feature'>$1</pre>")
    @text = @text.replace(/(Scenario:[^\n]*)/gi, "<pre class='keyword scenario'>$1</pre>")
    @text = @text.replace(/((Given|When|Then|And)[^\n]*)/gi, "<pre class='keyword outline'>$1</pre>")
    @text = @text.replace(/(\s*\|[^\n]*)/g, "<pre class='keyword table'>$1</pre>")
    @text = @text.replace(/(\"[^"\n]*\")/g, "<pre class='keyword quote'>$1</pre>")
    @text = @text.replace(/\n/g, '<br/>')

class ScenarioControls
  constructor: (@controls_bar)->
  scenario: ->
    $(@controls_bar + ' .scenario')
  scenario_button: ->
    $(@controls_bar + ' .scenario a')
  standard: ->
    $(@controls_bar + ' .standard')
  standard_button: ->
    $(@controls_bar + ' .standard a')

class Description
  constructor: (@scenario_description, @standard_description)->
  scenario: ->
    $(@scenario_description)
  standard: ->
    $(@standard_description)
  textarea: ->
    $(@standard_description + ' textarea')

class TicketForm
  constructor: (@form)->
    @scenario_mode = false
    @controls = new ScenarioControls(@form + ' .cucumber .controls')
    @description = new Description(@form + ' .cucumber .description', @form + ' #ticket_description_input')

    @controls.scenario_button().click( => @enable_scenario())
    @controls.standard_button().click( => @disable_scenario())
    @description.scenario().click( => @focus_on_textarea())
    @description.textarea().keyup( => @highlight() )
    @description.textarea().blur( => @textarea_blur() )
  enable_scenario: ->
    @scenario_mode = true
    @controls.scenario().hide()
    @controls.standard().show()
    @description.scenario().show()
    @description.standard().hide()
    text = @description.textarea().val()
    if(text == "")
      text = (new ScenarioOutline).build()
      @description.textarea().val(text)
    @description.scenario().html( (new CucumberSyntax(text)).highlight() )
  disable_scenario: ->
    @scenario_mode = false
    @controls.standard().hide()
    @controls.scenario().show()
    @description.scenario().hide()
    @description.standard().show()
  focus_on_textarea: ->
    @description.standard().show('fast')
    @description.textarea().focus()
  highlight: ->
    if @scenario_mode
      @description.scenario().html( (new CucumberSyntax(@description.textarea().val())).highlight() )
  textarea_blur: ->
    if @scenario_mode
      @description.standard().hide('fast')

class TicketEstimation
  constructor: (@selector)->
    @estimation_permission()
    @story().change(=> @estimation_permission())
  estimation_permission: ->
    if @story().val() != 'feature'
      @estimate(0)
      @points().hide('fast')
    else
      @points().show('fast')
  story: ->
    $(@selector + ' #ticket_story')
  points: ->
    $(@selector + ' #ticket_points_input')
  estimate: (points)->
    $(@selector + ' #ticket_points').val(points)

class TicketPresenter
  constructor: (@selector)->
    @controls = new ScenarioControls(@selector + ' .cucumber .controls')
    @controls.scenario_button().click(=> @enable_scenario())
    @controls.standard_button().click(=> @disable_scenario())
  enable_scenario: ->
    @controls.scenario().hide()
    @controls.standard().show()
    @scenario().show()
    @scenario().html((new CucumberSyntax(@description_content().html())).highlight())
    @description().hide()
  disable_scenario: ->
    @controls.standard().hide()
    @controls.scenario().show()
    @scenario().hide()
    @description().show()
  scenario: ->
    $(@selector + ' .cucumber .description')
  description: ->
    $(@selector + ' > .description')
  description_content: ->
    $(@selector + ' > .description .content')


$(=> new TicketForm('form.ticket'))
$(=> new TicketEstimation('form.ticket'))
$(=> new TicketPresenter('.show .ticket'))