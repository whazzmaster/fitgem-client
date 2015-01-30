require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Fitbit::Activity do
  describe '#fetch_all_on_date' do
    before(:each) do
      @user = double('User')
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
        'activities' => [
          {
              'activityId' => 17190,
              'activityParentId' => 90013,
              'activityParentName' => 'Walking',
              'calories' => 180,
              'description' => '3.0 mph',
              'distance' => 2,
              'duration' => 2400000,
              'hasStartTime' => true,
              'isFavorite' => true,
              'logId' => 23294694,
              'name' => 'Walking',
              'startTime' => '10:00',
              'steps' => 4427
          },
          {
              'activityId' => 17190,
              'activityParentId' => 90013,
              'activityParentName' => 'Walking',
              'calories' => 180,
              'description' => '3.0 mph',
              'distance' => 2,
              'duration' => 2400000,
              'hasStartTime' => true,
              'isFavorite' => true,
              'logId' => 23294694,
              'name' => 'Walking',
              'startTime' => '10:00',
              'steps' => 4427
          }
        ]
      }
    end

    context 'called with a logged-in user' do
      before(:each) do
        @user.stub(:present?).and_return(true)
        @user.stub(:linked?).and_return(true)
      end

      it 'fetches the data using the FitGem::Client instance on the user' do
        client = double('Fitgem::Client')
        client.should_receive(:activities_on_date).with('today').and_return(@data)
        @user.should_receive(:fitbit_data).and_return(client)
        Fitbit::Activity.fetch_all_on_date(@user, 'today')
      end

      it 'converts the returned data into Fitbit::Activity instances' do
        @user.stub_chain(:fitbit_data, :activities_on_date).and_return(@data)
        Fitbit::Activity.should_receive(:new).twice
        Fitbit::Activity.fetch_all_on_date(@user, 'today')
      end

      it 'returns an array of Fitbit::Activity instances' do
        @user.stub_chain(:fitbit_data, :activities_on_date).and_return(@data)
        activities = Fitbit::Activity.fetch_all_on_date(@user, 'today')
        activities.class.should == Array
        activities.count.should == 2
        activities.each {|a| a.class.should == Fitbit::Activity }
      end
    end

    context 'called with a non logged-in user' do
      before(:each) do
        @user.stub(:present?).and_return(true)
        @user.stub(:linked?).and_return(false)
      end

      it 'does not invoke the FitGem::Client instance on the user' do
        @user.should_not_receive(:fitbit_data)
        Fitbit::Activity.fetch_all_on_date(@user, 'today')
      end

      it 'returns an empty array' do
        Fitbit::Activity.fetch_all_on_date(@user, 'today').count.should == 0
      end
    end
  end

  describe '#log_activity' do
    before(:each) do
      @user = double('User')
      @user.stub(:present?).and_return(true)
    end

    context 'called with a logged-in user' do
      it 'calls log_activity on the FitGem::Client instance on the user' do
        @user.stub(:linked?).and_return(true)
        client = double('Fitgem::Client')
        client.should_receive(:log_activity)
        @user.should_receive(:fitbit_data).and_return(client)
        Fitbit::Activity.log_activity(@user, {'name' => 'Walking'})
      end
    end

    context 'called with a non logged-in user' do
      it 'does not call log_activity on the FitGem::Client instance on the user' do
        @user.stub(:linked?).and_return(false)
        @user.should_not_receive(:fitbit_data)
        Fitbit::Activity.log_activity(@user, { 'name' => 'Walking' })
      end
    end
  end
end