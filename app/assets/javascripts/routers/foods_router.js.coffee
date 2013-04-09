class FitgemClient.Routers.FoodsRouter extends Backbone.Router
  routes:
    "": "show"

  initialize: (options) ->
    Backbone.emulateHTTP = true
    @user = new FitgemClient.Models.User(options)

  show: ->
    alert('Not implemented: Foods Router')