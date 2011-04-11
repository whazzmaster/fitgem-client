class NotificationsController < ApplicationController
  
  def index
    @count = Notification.count
  end
  
  def create
    Notification.create( :body => params.to_s )
    render :status => 204
  end
  
end
