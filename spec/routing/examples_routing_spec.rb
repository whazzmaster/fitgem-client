require 'spec_helper'

describe "routes for user_info example controllers" do
  it "INDEX is routable" do
    { :get => '/examples/user_info' }.should be_routable
  end
end