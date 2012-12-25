class Fitbit::User < Fitbit::Data
  attr_accessor :fitbit_id, :display_name, :city, :state, :gender, :date_of_birth

  def initialize(user)
    super(user)

    if @logged_in && @linked
      user_info = user.fitbit_data.user_info['user']

      # Uncomment to view the data that is returned by the Fitbit service
      # ActiveRecord::Base.logger.info user_info

      @fitbit_id = user_info['encodedId']
      @linked = user.linked?
      @display_name = user_info['displayName']
      @city = user_info['city']
      @state = user_info['state']
      @gender = user_info['gender']
      @date_of_birth = user_info['date_of_birth']
    end
  end
end