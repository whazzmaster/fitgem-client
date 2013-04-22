FitgemClient.Views.Foods ||= {}

class FitgemClient.Views.Foods.FoodSearchView extends Backbone.View
  template: JST['templates/resources/foods/search']
  tagName: 'div'
  className: 'live-data-form-container'

  events:
    'click .search-results li': 'selectFoodItem'
    'click #food-search-btn': 'submitSearch'

  initialize: ->
    @childViews = []
    @collection = new FitgemClient.Collections.FoodCollection()
    @collection.on 'add', @add
    @collection.on 'remove', @remove
    @collection.on 'sync', @renderList
    return

  add: (model, collection, options) =>
    li = new FitgemClient.Views.Foods.ShowListView({model: model})
    @childViews.push(li)

  remove: (model, collection, options) =>
    view_to_remove = null
    for childView in @childViews
      if childView.model.name == model.name
        view_to_remove = childView
        break
    @childViews = _.without(@childViews, view_to_remove)

  render: ->
    $(@el).html(@template({}))
    return this

  # Empty the DOM of the list and rebuild from
  # the current list of views
  renderList: =>
    $('#food-search-results').empty()
    for childView in @childViews
      $('#food-search-results').append(childView.render().el)

  selectFoodItem: (event) =>
    event.preventDefault()
    foodName = $(event.currentTarget).find('strong').text()
    models = @collection.where({name: foodName})
    detailView = new FitgemClient.Views.Foods.ShowDetailView({model: models[0]})
    $('#selected-food-details').html(detailView.render().el)

  submitSearch: (event) ->
    event.preventDefault();
    searchTerm = $('#food-search-term').val()
    @collection.setSearchTerm(searchTerm)
    @collection.fetch
      remove: true
      update: true
      silent: false

