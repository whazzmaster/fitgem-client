FitgemClient.Views.Resources ||= {}

class FitgemClient.Views.Resources.NoActivitiesView extends Backbone.View
  template: JST['templates/resources/activities/no_activities']

  tagName: 'tr'
  className: 'warning'

  render: ->
    date = moment(@model.date)
    $(@el).html(@template({date: moment(date).format("MMMM Do, YYYY")}))
    return this