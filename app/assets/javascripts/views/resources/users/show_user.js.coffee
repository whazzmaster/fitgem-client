FitgemClient.Views.Resources.Users ||= {}

class FitgemClient.Views.Resources.Users.ShowUserView extends Backbone.View
  template: JST['templates/resources/user/show']
  tagName: 'div'
  className: 'live-data-form-container'

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this