FitgemClient.Views.Common ||= {}

class FitgemClient.Views.Common.NotLoggedInView extends Backbone.View
  template: JST['templates/common/not_logged_in']

  render: ->
    $(@el).html(@template())
    return this