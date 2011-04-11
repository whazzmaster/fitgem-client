require 'spec_helper'

describe FitbitOauthController do

  describe "GET 'start'" do
    it "should be successful" do
      get 'start'
      response.should be_success
    end
  end

  describe "GET 'verify'" do
    it "should be successful" do
      get 'verify'
      response.should be_success
    end
  end

end
