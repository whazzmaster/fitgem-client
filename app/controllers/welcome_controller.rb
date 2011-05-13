require 'fitbit_client_wrapper'

class WelcomeController < ApplicationController

  def index
    if user_signed_in? && current_user.fitbit_account.verified?
      client = FitgemClientWrapper.new(current_user.fitbit_account)
	    @info = client.user_info['user']
    end
  end

end
