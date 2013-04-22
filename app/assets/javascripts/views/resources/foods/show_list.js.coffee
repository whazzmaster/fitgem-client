FitgemClient.Views.Resources.Foods ||= {}

class FitgemClient.Views.Resources.Foods.ShowListView extends Backbone.View
  template: JST['templates/resources/foods/show_list']
  tagName: 'li'

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this
