class Api::BodyMeasurementsController < ApplicationController
  def show
    @body = Fitbit::BodyMeasurements.new current_user
  end
end