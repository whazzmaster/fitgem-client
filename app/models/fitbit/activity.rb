class Fitbit::Activity < Fitbit::Data
  attr_accessor :activityId, :activityParentId, :activityParentName, :calories, :description,
                :distance, :duration, :hasStartTime, :isFavorite, :logId, :name, :startTime, :steps

  def initialize(activity_data, unit_measurement_mappings)
    @activityId = activity_data['activityId']
    @activityParentId = activity_data['activityParentId']
    @activityParentName = activity_data['activityParentName']
    @calories = activity_data['calories']
    @description = activity_data['description']
    @distance = "#{activity_data['distance']} #{unit_measurement_mappings[:distance]}" if activity_data['distance']
    @duration = Time.at(activity_data['duration']/1000).utc.strftime("%H:%M:%S") if activity_data['duration']
    @hasStartTime = activity_data['hasStartTime']
    @logId = activity_data['logId']
    @name = activity_data['name']
    @startTime = activity_data['startTime']
    @steps = activity_data['steps']

    # Uncomment to view the data that is returned by the Fitbit service
    # ActiveRecord::Base.logger.info activity_data
  end

  def self.fetch_all_on_date(user, date)
    activity_objects = []
    if user.present? && user.linked?
      activities = user.fitbit_data.activities_on_date(date)['activities']
      activity_objects = activities.map {|a| Fitbit::Activity.new(a, user.unit_measurement_mappings) }
    end
    activity_objects
  end

  def self.log_activity(user, activity)
    if user.present? && user.linked?
      user.fitbit_data.log_activity(activity)
    end
  end
end

# Sample response from fitbit.com api
#{"activityId"=>17151,
# "activityParentId"=>90013,
# "activityParentName"=>"Walking",
# "calories"=>54,
# "description"=>"less than 2 mph, strolling very slowly",
# "distance"=>0.5,
# "duration"=>1200000,
# "hasStartTime"=>true,
# "isFavorite"=>true,
# "logId"=>21537078,
# "name"=>"Walking",
# "startTime"=>"11:45",
# "steps"=>1107}