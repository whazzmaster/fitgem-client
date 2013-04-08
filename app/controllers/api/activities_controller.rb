class Api::ActivitiesController < ApplicationController
  def index
    activity_date = params[:date] ? params[:date] : 'today'
    @activities = Fitbit::Activity.fetch_all_on_date(current_user, activity_date)
  end

  def create
    activity_data = {
      activityId: params[:activityId],
      durationMillis: params[:duration].to_i*60*1000,
      startTime: params[:startTime],
      date: params[:date],
      distance: params[:distance],
      distanceUnit: Fitgem::ApiDistanceUnit.miles
    }
    @activity = Fitbit::Activity.log_activity(current_user, activity_data)
  end
end
