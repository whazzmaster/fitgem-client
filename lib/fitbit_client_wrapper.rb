class FitgemClientWrapper
  
  def initialize(fb_account)
    return nil if fb_account.nil?
    return nil unless fb_account.verified?
    @client = Fitgem::Client.new({:consumer_key => APP_CONFIG[:fitbit_consumer_key], :consumer_secret => APP_CONFIG[:fitbit_consumer_secret], :token => fb_account.access_token, :secret => fb_account.access_secret, :user_id => fb_account.fb_user_id})
  end
  
  def method_missing(name, *args)
    @client.send(name, *args)
  end
  
end