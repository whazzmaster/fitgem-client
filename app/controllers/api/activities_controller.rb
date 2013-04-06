class Api::ActivitiesController < ApplicationController
  def index
    activity_date = params[:date] ? params[:date] : 'today'
    @activities = Fitbit::Activity.fetch_all_on_date(current_user, activity_date)
  end
end