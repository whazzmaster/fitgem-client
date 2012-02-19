class Api::UsersController < ApplicationController

  def show
    client = conditionally_create_client
    logged_in = user_signed_in?

    @user = Fitbit::User.new logged_in

    unless client.nil?
      info = client.user_info['user']
      @user.load info
    end
  end
end