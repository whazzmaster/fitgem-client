class FitgemClient.Models.BodyMeasurements extends Backbone.Model
  url: "/api/body_measurements.json"

  defaults:
    logged_in: false
    linked: false
    bicep: null
    bmi: null
    calf: null
    chest: null
    fat: null
    forearm: null
    hips: null
    neck: null
    thigh: null
    waist: null
    weight: null