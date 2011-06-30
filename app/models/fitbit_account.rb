class FitbitAccount < ActiveRecord::Base
  belongs_to :user
  
  before_save :default_user_id
  
  def set_request_token(token, secret)
    self.request_token = token
    self.request_secret = secret
  end
  
  def set_request_token!(token, secret)
    set_request_token(token, secret)
    save
  end
  
  def verified?
    !self.access_token.nil? && !self.access_token.empty? && !self.access_secret.nil? && !self.access_secret.empty?
  end
  
  def verify(token, secret, verifier)
    self.access_token = token
    self.access_secret = secret
    self.verifier = verifier
  end
  
  def verify!(token, secret, verifier)
    verify(token, secret, verifier)
    save
  end
  
  def clear!
    self.request_token = nil
    self.request_secret = nil
    self.access_token = nil
    self.access_secret = nil
    self.verifier = nil
    save
  end
  
  protected
  
  def default_user_id
    self.fb_user_id = '-' if self.fb_user_id.nil?
  end
end
