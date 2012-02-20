FitgemClient.Views.Common ||= {}

class FitgemClient.Views.Common.ConnectionErrorView extends Backbone.View
  template: JST['templates/common/connection_error']

  render: ->
    $(@el).html(@template())
    return this