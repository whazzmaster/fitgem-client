class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    current_user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider     = auth.provider
      user.uid          = auth.uid
      user.username     = auth.info.nickname
      user.oauth_token  = auth['credentials']['token']
      user.oauth_secret = auth['credentials']['secret']
      user.remember_me  = true
    end

    # The Fitbit API has changed and subsequent logins via OAuth result in new user token/secret
    # being generated, which invalidates the previously stored credentials. So now, if we already
    # had a record for the user we must check whether the credentials have changed and store the
    # new ones.
    #
    # See https://groups.google.com/forum/?hl=en&lnk=gcimh#!topic/fitbit-api/Win6-rrD7rc for more
    # information.
    if current_user.oauth_token != auth['credentials']['token'] && current_user.oauth_secret != auth['credentials']['secret']
      current_user.oauth_token = auth['credentials']['token']
      current_user.oauth_secret = auth['credentials']['secret']
      current_user.save
    end

    current_user
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
                :user_id => uid,
                :ssl => true
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
