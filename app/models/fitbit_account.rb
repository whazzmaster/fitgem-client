class FitbitAccount < ActiveRecord::Base
  belongs_to :user
  
  def verified?
    self.access_token && self.access_secret
  end
  
  def verify(token, secret)
    self.access_token = token
    self.access_secret = secret
  end
  
  def verify!(token, secret)
    verify(token, secret)
    save
  end
end
