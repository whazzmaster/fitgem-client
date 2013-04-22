FitgemClient.Views.Resources ||= {}

class FitgemClient.Views.Resources.IndexActivitiesView extends Backbone.View
  template: JST['templates/resources/activities/index']

  events:
    "click #change-activity-date-btn": "dateChanged"

  initialize: (options) ->
    @rendered = false

    @child_views = []
    @collection.each(@add)

    # TODO [zjm 2013-04-06]: Unsure why this isn't working, but I'm leaving
    # the code to try to fix at a later date. In theory I should just be able
    # to @collection.reset() and then @collection.fetch() and due to the
    # following lines it should automatically trigger view updates, but since
    # the @add and @remove methods aren't fired even when the collection contents
    # are updated this isn't happening. Any Backbone.js experts out there that
    # can help please submit a pull request or send me a message about this!
    _.extend(@collection, Backbone.Events)
    @collection.on 'add', @add
    @collection.on 'remove', @remove

  add: (model) =>
    child_view = new FitgemClient.Views.Resources.ShowActivityView({ model: model })
    @child_views.push(child_view)

    if @rendered
      @render()

  remove: (model) =>
    view_to_remove = null
    for child_view in @child_views
      if child_view.model == model
        view_to_remove = child_view
        break
    @child_views = _.without(@child_views, view_to_remove)

    if @rendered
      @render()

  # If we're rendering without any child_views (created when @add is called)
  # then we'll create the NoActivitiesView with the selected date and render
  # it into our element. If we did find activities in the collection, and
  # created subviews for them via the @add method, then render each view and
  # insert it into our table right before the footer. This should ensure that
  # the activities are viewed in the order they were delivered from the server.
  # Also, initialize the datepicker field and set the date to the one selected
  # set on the collection.
  render: ->
    $(@el).html(@template({}))
    activityDate = @collection.getDate()
    $(@el).find('.datepicker').val(activityDate)

    if @child_views.length == 0
      view = new FitgemClient.Views.Resources.NoActivitiesView(model: {date: activityDate})
      $(@el).find("tr#activities-table-footer").before(view.render().el)
    else
      for child_view in @child_views
        $(@el).find("tr#activities-table-footer").before(child_view.render().el)

    $(@el).find('.datepicker').datepicker({format: 'yyyy-mm-dd', autoclose: true})
    @rendered = true
    return this

  # When the user changes the date via the datepicker in the element then
  # reset the collection, update the date (used in the query to the server),
  # and then do a fetch.
  dateChanged: ->
    @collection.reset()
    @collection.setDate($(@el).find('.datepicker').val())
    @collection.fetch
      success: =>
        # Reset the collection of subviews
        @child_views = []
        if @collection.length > 0
          @collection.each(@add)
        else
          # Need to do this to force an update to the 'no activities found'
          # subview if no activities were returned from the server.
          @render()
      failure: =>
        @child_views = []
        @render()
