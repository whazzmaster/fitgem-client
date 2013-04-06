class Fitbit::Activity < Fitbit::Data
  attr_accessor :activityId, :activityParentId, :activityParentName, :calories, :description,
                :distance, :duration, :hasStartTime, :isFavorite, :logId, :name, :startTime, :steps

  def initialize(activity_data)
    @activityId = activity_data['activityId']
    @activityParentId = activity_data['activityParentId']
    @activityParentName = activity_data['activityParentName']
    @calories = activity_data['calories']
    @description = activity_data['description']
    @distance = activity_data['distance']
    @duration = activity_data['duration']
    @hasStartTime = activity_data['hasStartTime']
    @logId = activity_data['logId']
    @name = activity_data['name']
    @startTime = activity_data['startTime']
    @steps = activity_data['steps']
  end

  def self.fetch_all_on_date(user, date)
    activity_objects = []
    if user.present? && user.linked?
      activities = user.fitbit_data.activities_on_date(date)['activities']
      activity_objects = activities.map {|a| Fitbit::Activity.new(a) }
    end
    activity_objects
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