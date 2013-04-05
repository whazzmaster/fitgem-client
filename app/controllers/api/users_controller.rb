class Api::UsersController < ApplicationController
  def show
    @user = Fitbit::User.new(current_user)
  end
end