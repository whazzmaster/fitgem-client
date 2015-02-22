require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Fitbit::Data do
  describe '.data_available?' do
    before(:each) do
      @user = double('User')
    end

    it 'returns true when the user is linked to fitbit via oauth' do
      @user.stub(:linked?).and_return(true)
      Fitbit::Data.new(@user).data_available?.should be true
    end

    it 'returns false when the user is not linked to fitbit via oauth' do
      @user.stub(:linked?).and_return(false)
      Fitbit::Data.new(@user).data_available?.should be false
    end


  end
end
