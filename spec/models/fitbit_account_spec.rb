require 'spec_helper'

describe FitbitAccount do
  describe "verification status" do
    before(:each) do
      @fba = Factory.create(:fitbit_account)
    end
    
    it "reports true if both access token and access secret are stored" do
      @fba.verified?.should == true
    end
    
    it "reports false if the access token is nil or empty" do
      @fba.access_token = nil
      @fba.verified?.should == false
      @fba.access_token = ""
      @fba.verified?.should == false
    end
    
    it "reports false if only access token is stored" do
      @fba.access_secret = nil
      @fba.verified?.should == false
      @fba.access_secret = ""
      @fba.verified?.should == false
    end
  end

  describe "subject" do
    before(:each) do
      @fba = Factory.create(:fitbit_account)
    end
    
    it "calls default_user_id on save to check the current fitbit user id" do
      @fba.should_receive(:default_user_id)
      @fba.save
    end
    
    it "sets the default user id on save unless set by user" do
      @fba.fb_user_id = nil
      @fba.save
      @fba.fb_user_id.should == "-"
    end
  end
end