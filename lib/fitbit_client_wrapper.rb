class FitgemClientWrapper

  def initialize(fb_account)
    return nil if fb_account.nil?
    return nil unless fb_account.verified?
    @client = Fitgem::Client.new(:consumer_key => APP_CONFIG[:fitbit_consumer_key], :consumer_secret => APP_CONFIG[:fitbit_consumer_secret], :token => fb_account.access_token, :secret => fb_account.access_secret, :user_id => fb_account.fb_user_id)
  end

  def unit_measurement_mappings
    @unit_mappings ||= {
      :distance => @client.label_for_measurement(:distance),
      :duration => @client.label_for_measurement(:duration),
      :elevation => @client.label_for_measurement(:elevation),
      :height => @client.label_for_measurement(:height),
      :weight => @client.label_for_measurement(:weight),
      :measurements => @client.label_for_measurement(:measurements),
      :liquids => @client.label_for_measurement(:liquids),
      :blood_glucose => @client.label_for_measurement(:blood_glucose)
    }
  end

  def method_missing(name, *args)
    @client.send(name, *args)
  end

end