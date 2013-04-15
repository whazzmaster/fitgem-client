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

class FitgemClient.Collections.FoodCollection extends Backbone.Collection
  defaults:
    searchTerm: ''

  model: FitgemClient.Models.FoodItem

  url: ->
    if @searchTerm?
      '/api/foods.json?q=' + @searchTerm
    else
      '/api/foods.json'

  setSearchTerm: (term) ->
    @searchTerm = term

  getSearchTerm: ->
    @searchTerm


