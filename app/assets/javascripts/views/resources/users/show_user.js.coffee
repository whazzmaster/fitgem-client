FitgemClient.Views.Resources ||= {}

class FitgemClient.Views.Resources.ShowUserView extends Backbone.View
  template: JST['templates/resources/user/show']

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this