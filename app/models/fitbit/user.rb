class Fitbit::User < Fitbit::Data
  attr_accessor :logged_in, :linked, :fitbit_id, :display_name, :city, :state, :gender, :date_of_birth

  def initialize(logged_in)
    @logged_in = logged_in
    @linked = false
  end

  def load(data)
    if @logged_in
      @fitbit_id = data['encodedId']
      @linked = true unless @fitbit_id.nil?
      @display_name = data['displayName']
      @city = data['city']
      @state = data['state']
      @gender = data['gender']
      @date_of_birth = data['date_of_birth']
    end
  end
end