class Fitbit::Data
  attr_accessor :logged_in, :linked

  def initialize(logged_in)
    @logged_in = logged_in
    @linked = false
  end
end