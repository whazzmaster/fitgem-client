require 'spec_helper'

describe WelcomeController do
  context "when the user is not logged in" do
    before(:each) do
      @fitbit_account = mock(:fitbit_account)
      @fitbit_account.stub(:verified?)
      User.any_instance.stub(:fitbit_account).and_return(@fitbit_account)
    end
    
    it "should not check the verified state of the fitbit account" do
      @fitbit_account.should_not_receive(:verified?)
      get :index
    end
    
    it "should not create the fitgem client wrapper" do
      FitgemClientWrapper.should_not_receive(:new)
      get :index
    end
  end

  context "when the user is logged in and the fitbit account is not verified" do
    before(:each) do
      sign_in FactoryGirl.create(:user)
            
      @fitbit_account = mock(:fitbit_account)
      @fitbit_account.stub(:verified?).and_return(false)
      User.any_instance.stub(:fitbit_account).and_return(@fitbit_account)
    end
    
    it "should check whether the account is verified" do
      @fitbit_account.should_receive(:verified?)
      get :index
    end
    
    it "should not create the fitgem client wrapper" do
      FitgemClientWrapper.should_not_receive(:new)
      get :index
    end
  end
  
  context "when the user is logged in and the fitbit account is verified" do
    before(:each) do
      sign_in FactoryGirl.create(:user)
            
      @fitbit_account = mock(:fitbit_account)
      @fitbit_account.stub(:verified?).and_return(true)
      User.any_instance.stub(:fitbit_account).and_return(@fitbit_account)
      
      @client_wrapper = mock(FitgemClientWrapper)
      @client_wrapper.stub(:user_info).and_return({"user" => "stuff"})
      FitgemClientWrapper.stub(:new).and_return(@client_wrapper)
    end
    
    it "should check whether the account is verified" do
      @fitbit_account.should_receive(:verified?)
      get :index
    end
    
    it "should create the fitgem client wrapper" do
      FitgemClientWrapper.should_receive(:new).and_return(@client_wrapper)
      get :index
    end
    
    it "should set the @info variable by calling the user_info method on the client wrapper" do
      assigns(:info)
      @client_wrapper.should_receive(:user_info)
      get :index
    end
  end
end
