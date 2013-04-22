FitgemClient.Views.Resources.Foods ||= {}

class FitgemClient.Views.Resources.Foods.ShowDetailView extends Backbone.View
  template: JST['templates/resources/foods/show_detail']

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this
