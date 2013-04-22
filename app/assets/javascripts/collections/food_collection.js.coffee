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
