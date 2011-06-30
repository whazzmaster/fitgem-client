require 'fitbit_client_wrapper'
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def conditionally_create_client
    client = nil
    if user_signed_in? && current_user.fitbit_account.verified?
      client = FitgemClientWrapper.new(current_user.fitbit_account)
    end
    client
  end
end
