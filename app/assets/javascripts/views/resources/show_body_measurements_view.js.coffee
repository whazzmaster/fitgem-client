FitgemClient.Views.Resources ||= {}

class FitgemClient.Views.Resources.ShowBodyMeasurementsView extends Backbone.View
  template: JST['templates/resources/body_measurements/show']

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this