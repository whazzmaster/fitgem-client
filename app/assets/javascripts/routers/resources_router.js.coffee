class FitgemClient.Routers.ResourcesRouter extends Backbone.Router
  routes:
    "" : "show"

  initialize: (options) ->
    Backbone.emulateHTTP = true
    @user = new FitgemClient.Models.User(options)

  show: ->
    if @user.get("linked")
      if $('#fitbit-user-data')
        @user.fetch
          success: =>
            user_view = new FitgemClient.Views.Resources.ShowUserView(model: @user)
            $('#fitbit-user-data').html(user_view.render().el)
          error: =>
            alert "There was an error while retrieving the fitbit user data"

    else if @user.get("logged_in")
      view = new FitgemClient.Views.Common.AccountsNotLinkedView()
      $(".fitbit-data-view").html(view.render().el)

    else
      view = new FitgemClient.Views.Common.NotLoggedInView()
      $(".fitbit-data-view").html(view.render().el)

