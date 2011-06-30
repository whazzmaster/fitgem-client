class WelcomeController < ApplicationController

  def index
    client = conditionally_create_client
    @info = client.user_info['user'] unless client.nil?
  end
  
  def about
  end

end
