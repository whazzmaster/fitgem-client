class FitgemClient.Models.Activity extends Backbone.Model
  paramRoot: "activity"

  defaults:
    name: ""
    activityId: null
    logId: null
    calories: null
    distance: null
    duration: null
    steps: null

  url: ->
    if @isNew()
      "/api/activities.json"
    else
      null