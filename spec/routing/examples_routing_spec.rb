require 'spec_helper'

describe "route for examples main controller" do
  it "handles INDEX action" do
    { :get => '/examples' }.should be_routable
  end
end

describe "routes for resources example controllers" do
  it "INDEX is routable" do
    { :get => '/examples/resources' }.should be_routable
  end
end