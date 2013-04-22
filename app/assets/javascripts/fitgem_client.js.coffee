#= require_self
#= require_tree ./routers
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

window.FitgemClient =
  Models: {}
  Collections: {}
  Views: { Resources: {} }
  Routers: {}

  init: (options) ->
    switch options.routerType
      when 'user_information' then @router = new FitgemClient.Routers.UserInformationRouter(options)
      when 'body_measurements' then @router = new FitgemClient.Routers.BodyMeasurementsRouter(options)
      when 'activities' then @router = new FitgemClient.Routers.ActivitiesRouter(options)
      when 'foods' then @router = new FitgemClient.Routers.FoodsRouter(options)
      else alert('Invalid (or no) router specified in FitgemClient contructor.')
    Backbone.history.start()