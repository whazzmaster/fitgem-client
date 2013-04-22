class FitgemClient.Routers.FoodsRouter extends Backbone.Router
  routes:
    "": "show"

  initialize: (options) ->
    Backbone.emulateHTTP = true
    @user = new FitgemClient.Models.User(options)

  show: ->
    if @user.get("linked")
      if $('#fitbit-food-search')
        food_search_view = new FitgemClient.Views.Resources.Foods.FoodSearchView({})
        $('#fitbit-food-search').html(food_search_view.render().el)

    else if @user.get("logged_in")
      view = new FitgemClient.Views.Common.AccountsNotLinkedView()
      $(".fitbit-data-view").html(view.render().el)

    else
      view = new FitgemClient.Views.Common.NotLoggedInView()
      $(".fitbit-data-view").html(view.render().el)