require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Fitbit::User do
  context 'created with a user with a linked account' do
    it 'sets the internal state according to the data returned by the fitbit client' do
      user = double('User')
      user.stub_chain(:fitbit_data, :user_info).and_return({
             'user' =>
               {
                 'encodedId' => 'N22445',
                 'displayName' => 'Zachery',
                 'city' => 'Madison',
                 'state' => 'WI',
                 'gender' => 'male',
                 'date_of_birth' => '1978-01-01'
               }
           })
      user.stub(:present?).and_return(true)
      user.stub(:linked?).and_return(true)

      fitbit_user = Fitbit::User.new(user)
      fitbit_user.display_name.should eq('Zachery')
      fitbit_user.fitbit_id.should eq('N22445')
      fitbit_user.city.should eq('Madison')
      fitbit_user.state.should eq('WI')
      fitbit_user.date_of_birth.should eq('1978-01-01')
      fitbit_user.linked.should eq(true)
    end
  end

  context 'created with a user without a linked account' do
    it "doesn't attempt to access the fitbit data" do
      user = double('User')
      user.stub(:linked?).and_return(false)
      user.should_not_receive(:fitbit_data)

      Fitbit::User.new(user)
    end
  end
end