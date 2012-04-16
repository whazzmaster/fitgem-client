#= require_self
#= require_tree ./routers
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views

window.FitgemClient =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: (options) ->
    @router = new FitgemClient.Routers.ResourcesRouter(options)
    Backbone.history.start()