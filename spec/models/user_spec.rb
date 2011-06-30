require 'spec_helper'

describe User do
  it "creates an empty fitbit_account when created" do
    FitbitAccount.should_receive(:new)
    User.create!( :password => 'meepmoop', :password_confirmation => 'meepmoop', :email => 'meep@moop.com' )
  end
end
