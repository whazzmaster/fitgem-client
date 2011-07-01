require 'spec_helper'

describe Examples::ResourcesController do
  describe "GET 'index'" do
    it "attempts to get access to the fitgem client wrapper" do
      Examples::ResourcesController.any_instance.should_receive(:conditionally_create_client)
      get :index
    end

    context "a fitgem client is successfully created" do
      before(:each) do
        @client = mock(FitgemClientWrapper)
        @client.stub(:user_info).and_return({"user" => "data"})
        @client.stub(:body_measurements_on_date).and_return({"body" => "data"})
        Examples::ResourcesController.any_instance.stub(:conditionally_create_client).and_return(@client)
      end

      it "sets the @info variable" do
        get :index
        assigns(:info).should_not be_nil
      end

      it "sets the @body_measurements variable" do
        get :index
        assigns(:body_measurements).should_not be_nil
      end
    end

    context "a fitgem client is not able to be created" do
      before(:each) do
        Examples::ResourcesController.any_instance.stub(:conditionally_create_client).and_return(nil)
      end

      it "does not set the @info variable" do
        get :index
        assigns(:info).should be_nil
      end

      it "does not set the @body_measurements variable" do
        get :index
        assigns(:body_measurements).should be_nil
      end
    end
  end
end
