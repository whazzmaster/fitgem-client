class User < ActiveRecord::Base
  has_one :fitbit_account

  after_create :create_fitbit_account

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def linked?
    if self.fitbit_account.nil?
      false
    else
      self.fitbit_account.verified?
    end
  end

  private

  def create_fitbit_account
    self.fitbit_account = FitbitAccount.new
    save
  end
end
