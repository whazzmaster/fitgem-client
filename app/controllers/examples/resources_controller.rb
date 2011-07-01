class Examples::ResourcesController < ApplicationController

  def index
    client = conditionally_create_client
    unless client.nil?
      @info = client.user_info['user']
      @body_measurements = client.body_measurements_on_date('today')
    end
  end
end
