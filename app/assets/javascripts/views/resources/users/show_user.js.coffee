FitgemClient.Views.Resources.Users ||= {}

class FitgemClient.Views.Resources.Users.ShowUserView extends Backbone.View
  template: JST['templates/resources/user/show']

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this