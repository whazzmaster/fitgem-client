require 'spec_helper'

describe FitgemOauthController do
  include Devise::TestHelpers
  
  context "when a user is not logged in" do
    it "redirects to the login page" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end
  
  context "when verify called without oauth_token or oauth_verifier" do
    before(:each) do
      sign_in Factory.create(:user)
    end
    
    it "redirects to root page" do
      get :verify
      response.should redirect_to(root_url)
    end
    
    it "sets a flash error message" do
      get :verify
      flash[:alert].should == "Could not verify your account with Fitbit"
    end
  end
  
  context "when verify is called with a valid oauth_token and oauth_verifier" do
    before(:each) do
      sign_in Factory.create(:user)
      
      @fitbit_account = mock(:fitbit_account)
      @fitbit_account.stub(:request_secret).and_return("abcdef")
      @fitbit_account.stub(:verify!)
      User.any_instance.stub(:fitbit_account).and_return(@fitbit_account)
      
      @access_token = mock(Object)
      @access_token.stub(:token)
      @access_token.stub(:secret)
      
      @fitgem_client = mock(:fitgem_client)
      @fitgem_client.stub(:authorize).and_return(@access_token)
      @fitgem_client.stub(:user_info).and_return({"user" => "zmoneype"})
      
      @token = "123456"
      @verifier = "78910111213"
    end
    
    after(:each) do
      get :verify, { :oauth_token => @token, :oauth_verifier => @verifier }
    end
    
    it "creates a fitgem client wrapper object" do
      Fitgem::Client.should_receive(:new).with({:consumer_key => APP_CONFIG[:fitbit_consumer_key], :consumer_secret => APP_CONFIG[:fitbit_consumer_secret], :user_id => '-'})
    end
    
    it "gets the stored request secret from the current user's fitbit_account record" do
      @fitbit_account.should_receive(:request_secret)
    end
    
    it "attempts to authorize on the fitgem client using the supplied verifier value" do
      Fitgem::Client.stub(:new).and_return(@fitgem_client)
      @fitgem_client.should_receive(:authorize).with(@token, "abcdef", { :oauth_verifier => @verifier})
    end
    
    it "sets the @info variable for use in the view" do
      assigns(:info)
    end
  end
end
