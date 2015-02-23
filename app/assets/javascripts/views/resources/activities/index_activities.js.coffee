FitgemClient.Views.Resources.Activities ||= {}

class FitgemClient.Views.Resources.Activities.IndexActivitiesView extends Backbone.View
  template: JST['templates/resources/activities/index']
  tagName: 'div'
  className: 'live-data-form-container'

  events:
    'click #change-activity-date-btn': 'dateChanged'

  initialize: (options) ->
    @childViews = []

    @collection.each(@add)
    @collection.on 'add', @add
    @collection.on 'remove', @remove
    @collection.on 'sync', @renderList

  add: (model, collection, options) =>
    childView = new FitgemClient.Views.Resources.Activities.ShowActivityView({ model: model })
    @childViews.push(childView)

  remove: (model, collection, options) =>
    view_to_remove = null
    for childView in @childViews
      if childView.model.name == model.name
        view_to_remove = childView
        break
    @childViews = _.without(@childViews, view_to_remove)

  # If we're rendering without any childView (created when @add is called)
  # then we'll create the NoActivitiesView with the selected date and render
  # it into our element. If we did find activities in the collection, and
  # created subviews for them via the @add method, then render each view and
  # insert it into our table right before the footer. This should ensure that
  # the activities are viewed in the order they were delivered from the server.
  # Also, initialize the datepicker field and set the date to the one selected
  # set on the collection.
  render: =>
    $(@el).html(@template({}))
    activityDate = @collection.getDate()
    $(@el).find('.datepicker').val(activityDate)

    @renderList()

    $(@el).find('.datepicker').fdatepicker({format: 'yyyy-mm-dd', autoclose: true})
    return this

  renderList: =>
    activityDate = @collection.getDate()
    $(@el).find('#activities-results-container').empty()
    if @childViews.length == 0
      view = new FitgemClient.Views.Resources.Activities.NoActivitiesView(model: {date: activityDate})
      $(@el).find('#activities-results-container').append(view.render().el)
    else
      for childView in @childViews
        $(@el).find('#activities-results-container').append(childView.render().el)

  # When the user changes the date via the datepicker in the element then
  # reset the collection, update the date (used in the query to the server),
  # and then do a fetch.
  dateChanged: ->
    $('#activities-fetch-spinner').css('visibility','visible')
    @collection.setDate($(@el).find('.datepicker').val())
    @collection.fetch
      remove: true
      update: true
      silent: false
      success: =>
        $('#activities-fetch-spinner').css('visibility', 'hidden')
      failure: =>
        $('#activities-fetch-spinner').css('visibility', 'hidden')
