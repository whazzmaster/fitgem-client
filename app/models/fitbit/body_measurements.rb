class Fitbit::BodyMeasurements < Fitbit::Data
  attr_accessor :bicep, :bmi, :calf, :chest, :fat, :forearm, :hips, :neck, :thigh, :waist, :weight

  def load(data, unit_measurement_mappings)
    @linked = true
    if @logged_in
      ['bicep','calf','chest','forearm','hips','neck','thigh','waist'].each do |type|
        self.send(type+"=", data[type].to_s+" "+unit_measurement_mappings[:measurements]) unless data[type] == 0
      end

      @bmi = data['bmi'].to_s unless data['bmi'] == 0
      @fat = data['fat'].to_s + "%" unless data['fat'] == 0
      @weight = data['weight'].to_s+" "+unit_measurement_mappings[:weight] unless data['weight'] == 0
    end
  end
end