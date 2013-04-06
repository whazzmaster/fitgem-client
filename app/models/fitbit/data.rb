class Fitbit::Data
  attr_accessor :logged_in, :linked

  def initialize(user)
    @logged_in = user.present?
    @linked = user.present? && user.linked?
  end

  def data_available?
    @linked
  end
end