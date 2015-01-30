require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Fitbit::BodyMeasurements do
  before(:each) do
    @user = double('User')
    @user.stub(:present?).and_return(true)
    @user.stub(:unit_measurement_mappings).and_return({
      :distance => 'miles',
      :duration => 'milliseconds',
      :elevation => 'feet',
      :height => 'inches',
      :weight => 'pounds',
      :measurements => 'inches',
      :liquids => 'fl oz',
      :blood_glucose => 'mg/dL'
    })
    @data = {
      'body' =>
        {
          'bicep' => 15,
          'bmi' => 30,
          'calf' => 10,
          'chest' => 40,
          'fat' => 33,
          'forearm' => 11,
          'hips' => 32,
          'neck' => 16,
          'thigh' => 23,
          'waist' => 34,
          'weight' => 185
        }
    }
  end

  describe '.initialize' do
    context 'called with a logged-in user' do
      before(:each) do
        @user.stub(:linked?).and_return(true)
      end

      it 'calls the body_measurements method of FitGem::Client on the user instance' do
        client = double('FitGem::Client')
        client.should_receive(:body_measurements_on_date).with('today').and_return(@data)
        @user.should_receive(:fitbit_data).and_return(client)
        Fitbit::BodyMeasurements.new(@user)
      end

      it 'applies the user\'s unit measurements to the values returned by FitGem::Client' do
        @user.stub_chain(:fitbit_data, :body_measurements_on_date).and_return(@data)
        measurements = Fitbit::BodyMeasurements.new(@user)

        measurements.bicep.should == '15 inches'
        measurements.bmi.should == '30'
        measurements.calf.should == '10 inches'
        measurements.chest.should == '40 inches'
        measurements.fat.should == '33%'
        measurements.forearm.should == '11 inches'
        measurements.hips.should == '32 inches'
        measurements.neck.should == '16 inches'
        measurements.thigh.should == '23 inches'
        measurements.waist.should == '34 inches'
        measurements.weight.should == '185 pounds'
      end
    end

    context 'called with a non logged-in user' do
      it 'does not call the body_measurements method of FitGem::Client on te user instance' do
        @user.stub(:linked?).and_return(false)
        @user.should_not_receive(:fitbit_data)
        Fitbit::BodyMeasurements.new(@user)
      end
    end
  end
end