class FitgemClient.Models.FoodItem extends Backbone.Model
  url: null

  defaults:
    brand: ''
    calories: 0
    defaultServingSize: 0
    name: ''
    defaultUnit: {id: 0, name: '', plural: ''}

  initialize: ->
    @on 'add', @computeDefaultServing
    @on 'change', @computeDefaultServing

  computeDefaultServing: =>
    defaultServingSize = @get('defaultServingSize')
    defaultUnit = @get('defaultUnit')
    if defaultServingSize == 1
      @set('defaultServing', defaultServingSize+' '+defaultUnit.name)
    else
      @set('defaultServing', defaultServingSize + ' ' + defaultUnit.plural)