class FitgemClient.Routers.ActivitiesRouter extends Backbone.Router
  routes:
    "": "show"

  initialize: (options) ->
    Backbone.emulateHTTP = true
    @user = new FitgemClient.Models.User(options)
    @activities = new FitgemClient.Collections.ActivitiesCollection()

  show: ->
    if @user.get("linked")
      if $('#fitbit-activities-data')
        @activities.setDate(moment().format('YYYY-MM-DD'))
        @activities.fetch
          success: =>
            activities_view = new FitgemClient.Views.Resources.IndexActivitiesView(collection: @activities)
            $('#fitbit-activities-data').html(activities_view.render().el)
          error: =>
            view = new FitgemClient.Views.Common.ConnectionErrorView()
            $(".fitbit-data-view").html(view.render().el)

      if $('#fitbit-log-activity-data')
        log_activity_view = new FitgemClient.Views.Resources.CreateActivityView()
        $('#fitbit-log-activity-data').html(log_activity_view.render().el)

    else if @user.get("logged_in")
      view = new FitgemClient.Views.Common.AccountsNotLinkedView()
      $(".fitbit-data-view").html(view.render().el)

    else
      view = new FitgemClient.Views.Common.NotLoggedInView()
      $(".fitbit-data-view").html(view.render().el)