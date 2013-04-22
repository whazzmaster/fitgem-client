FitgemClient.Views.Resources.BodyMeasurements ||= {}

class FitgemClient.Views.Resources.BodyMeasurements.ShowBodyMeasurementsView extends Backbone.View
  template: JST['templates/resources/body_measurements/show']

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this