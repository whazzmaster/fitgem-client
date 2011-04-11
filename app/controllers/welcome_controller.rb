class WelcomeController < ApplicationController

  def index
    @count = Notification.count
  end

end
