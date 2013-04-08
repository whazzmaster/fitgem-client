class Fitbit::BodyMeasurements < Fitbit::Data
  attr_accessor :bicep, :bmi, :calf, :chest, :fat, :forearm, :hips, :neck, :thigh, :waist, :weight

  def initialize(user)
    super(user)

    if @logged_in && @linked
      data = user.fitbit_data.body_measurements_on_date('today')['body']

      # Uncomment to view the data that is returned by the Fitbit service
      # ActiveRecord::Base.logger.info data         s

      ['bicep','calf','chest','forearm','hips','neck','thigh','waist'].each do |type|
        self.send(type+"=", data[type].to_s+" "+user.unit_measurement_mappings[:measurements]) unless data[type] == 0
      end

      @bmi = data['bmi'].to_s unless data['bmi'] == 0
      @fat = data['fat'].to_s + "%" unless data['fat'] == 0
      @weight = data['weight'].to_s+" "+user.unit_measurement_mappings[:weight] unless data['weight'] == 0
    end
  end
end