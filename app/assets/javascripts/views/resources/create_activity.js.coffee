FitgemClient.Views.Resources ||= {}

class FitgemClient.Views.Resources.CreateActivityView extends Backbone.View
  template: JST['templates/resources/activities/create']

  tagName: 'div'

  events:
    "click #log-activity-btn": "logActivity"

  render: ->
    if @model?
      $(@el).html(@template(@model.toJSON()))
    else
      $(@el).html(@template({}))
    # Setup the timepicker form input
    $(@el).find("#logStartTime").timepicker
      minuteStep: 1
      showMeridian: false
    # Setup the datepicker form input
    $(@el).find("#logDate").val(moment().format('YYYY-MM-DD')).datepicker
      format: "yyyy-mm-dd"
      autoclose: true
      todayBtn: 'linked'
      todayHighlight: true
    return this

  logActivity: (event) ->
    # Don't follow the link/process the form
    event.preventDefault()

    # Load up the model with data from the form
    @model = new FitgemClient.Models.Activity
      name: $(@el).find("#logActivityName").val()
      activityId: $(@el).find("#logActivityId").val()
      distance: $(@el).find("#logDistance").val()
      duration: $(@el).find("#logDuration").val()
      startTime: $(@el).find("#logStartTime").val()
      date: $(@el).find("#logDate").val()

    # Get a reference to our status container and insert the spinner
    status_el = $(@el).find("#log-activity-status")
    status_el.html("<img src='/assets/spinner.gif' /> Saving...")
    @model.save null,
      success: =>
        # Allow the user to jump directly to Fitbit to see the logged
        # activity on their dashboard.
        status_el.html("Success! <a href='http://www.fitbit.com/activities' target='_new'>View the logged activity on Fitbit.com</a>")
        status_el.addClass("alert alert-success")
      error: =>
        # If we had an error put up a generic error message
        status_el.html("There was an error saving the activity.")
        status_el.addClass("alert alert-error")

