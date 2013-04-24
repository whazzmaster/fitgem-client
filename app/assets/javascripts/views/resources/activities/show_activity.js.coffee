FitgemClient.Views.Resources.Activities ||= {}

class FitgemClient.Views.Resources.Activities.ShowActivityView extends Backbone.View
  template: JST['templates/resources/activities/show']
  tagName: 'tr'
  className: 'fetch-result'

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this