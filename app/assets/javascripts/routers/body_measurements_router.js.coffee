class FitgemClient.Routers.BodyMeasurementsRouter extends Backbone.Router
  routes:
    "": "show"

  initialize: (options) ->
    Backbone.emulateHTTP = true
    @user = new FitgemClient.Models.User(options)
    @body_measurements = new FitgemClient.Models.BodyMeasurements()

  show: ->
    if @user.get("linked")
      if $('#fitbit-body-measurements-data')
        @body_measurements.fetch
          success: =>
            user_view = new FitgemClient.Views.Resources.BodyMeasurements.ShowBodyMeasurementsView(model: @body_measurements)
            $('#fitbit-body-measurements-data').html(user_view.render().el)
          error: =>
            view = new FitgemClient.Views.Common.ConnectionErrorView()
            $(".fitbit-data-view").html(view.render().el)

    else if @user.get("logged_in")
      view = new FitgemClient.Views.Common.AccountsNotLinkedView()
      $(".fitbit-data-view").html(view.render().el)

    else
      view = new FitgemClient.Views.Common.NotLoggedInView()
      $(".fitbit-data-view").html(view.render().el)