class Api::BodyMeasurementsController < ApplicationController

  def show
    client = conditionally_create_client
    @body = Fitbit::BodyMeasurements.new user_signed_in?

    unless client.nil?
      info = client.body_measurements_on_date('today')
      @body.load info['body'], client.unit_measurement_mappings
    end
  end
end