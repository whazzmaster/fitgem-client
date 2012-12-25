class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :oauth_token, :oauth_secret

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.oauth_token = auth['credentials']['token']
      user.oauth_secret = auth['credentials']['secret']
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def linked?
    oauth_token.present? && oauth_secret.present?
  end

  def fitbit_data
    raise "Account is not linked with a Fitbit account" unless linked?
    @client ||= Fitgem::Client.new(
                :consumer_key => ENV["FITBIT_CONSUMER_KEY"],
                :consumer_secret => ENV["FITBIT_CONSUMER_SECRET"],
                :token => oauth_token,
                :secret => oauth_secret,
                :user_id => uid
              )
  end

  def has_fitbit_data?
    !@client.nil?
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

end
