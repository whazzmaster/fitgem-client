FitgemClient.Views.Resources ||= {}

class FitgemClient.Views.Resources.ShowActivityView extends Backbone.View
  template: JST['templates/resources/activities/show']

  tagName: 'tr'

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this