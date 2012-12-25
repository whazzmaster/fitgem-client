require 'fitbit_client_wrapper'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def conditionally_create_client
    client = nil
    if user_signed_in? && current_user.linked?
      client = FitgemClientWrapper.new(current_user.oauth_token, current_user.oauth_secret, current_user.uid)
    end
    client
  end
end
