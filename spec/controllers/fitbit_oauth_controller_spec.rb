require 'spec_helper'

describe FitgemOauthController do
  
  context "when a user is not logged in" do
    it "redirects to the login page" do
      get :index
      response.should redirect_to(new_user_session_path)
      get :verify
      response.should redirect_to(new_user_session_path)
      get :start
      response.should redirect_to(new_user_session_path)
      get :info
      response.should redirect_to(new_user_session_path)
      get :disconnect
      response.should redirect_to(new_user_session_path)
    end
  end
  
  context "when verify is called without oauth_token or oauth_verifier" do
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
    
    it "creates a fitgem client object" do
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
  
  context "when verify is called without a valid oauth_token or oauth_verifier" do
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
      @fitgem_client.stub(:authorize).and_raise(Exception.new)
      
      @token = "123456"
      @verifier = "78910111213"
    end
    
    it "redirects to the oauth index path" do
      get :verify, { :oauth_token => @token, :oauth_verifier => @verifier }
      response.should redirect_to(fitbit_index_path)
    end
    
    it "sets the flash message" do
      get :verify, { :oauth_token => @token, :oauth_verifier => @verifier }
      flash[:alert].should == "Oops, there wasn't a valid OAuth session on Fitbit. Try to authorize again."
    end
  end
  
  context "when start is called" do
    before(:each) do
      sign_in Factory.create(:user)
      
      @request_token = mock(Object)
      @request_token.stub(:token)
      @request_token.stub(:secret)
      @request_token.stub(:to_s).and_return('12345')

      @fitbit_account = mock(:fitbit_account)
      @fitbit_account.stub(:set_request_token!)
      @fitbit_account.stub(:request_token).and_return(@request_token)
      User.any_instance.stub(:fitbit_account).and_return(@fitbit_account)
      
      @fitgem_client = mock(:fitgem_client)
      @fitgem_client.stub(:request_token).and_return(@request_token)
      Fitgem::Client.stub(:new).and_return(@fitgem_client)
    end
    
    it "creates a fitgem client object" do
      Fitgem::Client.should_receive(:new).with({:consumer_key => APP_CONFIG[:fitbit_consumer_key], :consumer_secret => APP_CONFIG[:fitbit_consumer_secret]})
      post :start
    end
    
    it "gets the request token from the fitgem client" do
      @fitgem_client.should_receive(:request_token)
      post :start
    end
    
    it "sets the request token on the current user's fitbit_account record" do
      @fitbit_account.should_receive(:set_request_token!)
      post :start
    end
    
    it "gets the calculated request token from the fitbit_account record on the user object" do
      @fitbit_account.should_receive(:request_token)
      post :start
    end
    
    it "redirects the user to the fitbit.com oauth url" do
      post :start
      response.should redirect_to("http://www.fitbit.com/oauth/authorize?oauth_token=12345")
    end
  end
  
  context "when info is called" do
    before(:each) do
      sign_in Factory.create(:user)

      @fitbit_account = mock(:fitbit_account)
      @fitbit_account.stub(:set_request_token!)
      @fitbit_account.stub(:request_token).and_return(@request_token)
      User.any_instance.stub(:fitbit_account).and_return(@fitbit_account)
    end
    
    it "checks whether the current user's fitbit_account is verified" do
      @fitbit_account.should_receive(:verified?)
      get :info
    end
    
    context "and the account is not verified" do
      before(:each) do
        @fitbit_account.stub(:verified?).and_return(false)
      end
      
      it "redirects to the oauth index page" do
        get :info
        response.should redirect_to(fitbit_path)
      end
      
      it "sets the flash to an error message" do
        get :info
        flash[:alert].should == "Your test account is not connected to a Fitbit account. "
      end
    end
    
    context "and the account is verified" do
      before(:each) do
        @fitbit_account.stub(:verified?).and_return(true)
        
        @client_wrapper = mock(FitgemClientWrapper)
        @client_wrapper.stub(:user_info).and_return({"user" => "stuff"})
        FitgemClientWrapper.stub(:new).and_return(@client_wrapper)
      end
      
      it "creates a fitbit client wrapper" do
        FitgemClientWrapper.should_receive(:new).with(@fitbit_account)
        get :info
      end
      
      it "sets the @info variable from the client" do
        assigns(:info)
        get :info
      end
    end
  end
  
  context "when disconnect is called" do
    before(:each) do
      sign_in Factory.create(:user)

      @fitbit_account = mock(:fitbit_account)
      @fitbit_account.stub(:clear!)
      User.any_instance.stub(:fitbit_account).and_return(@fitbit_account)
    end
    
    it "calls clear! on the fitbit_account record" do
      @fitbit_account.should_receive(:clear!)
      post :disconnect
    end
    
    it "sets the flas with a notification message" do
      post :disconnect
      flash[:notice].should == "Your test account has been disconnected from your Fitbit account"
    end
    
    it "redirects to the root url" do
      post :disconnect
      response.should redirect_to(root_path)
    end
  end
end
