class FitgemClient.Models.User extends Backbone.Model
  url: "/api/user.json"

  defaults:
    logged_in: false
    linked: false
    fitbit_id: null
    display_name: null
    city: null
    state: null
    gender: null
    date_of_birth: null