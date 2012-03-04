class Fitbit::User < Fitbit::Data
  attr_accessor :fitbit_id, :display_name, :city, :state, :gender, :date_of_birth

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