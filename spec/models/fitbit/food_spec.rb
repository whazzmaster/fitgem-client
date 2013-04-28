require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Fitbit::Food do
  describe '#search' do
    before(:each) do
      @user = double('User')
      @user.stub_chain(:fitbit_data, :find_food).and_return({
              'foods' =>
                [
                    {
                      "accessLevel" => "PUBLIC",
                      "brand" => "",
                      "calories" => 80,
                      "defaultServingSize" => 1,
                      "defaultUnit" => { "id" => 204, "name" => "medium", "plural" => "mediums" },
                      "foodId" => 81409,
                      "locale" => "en_US",
                      "name" => "Apple",
                      "units" => [204, 179, 226, 180, 147, 389]
                    },
                    { "accessLevel" => "PUBLIC",
                      "brand" => "",
                      "calories" => 232,
                      "defaultServingSize" => 1,
                      "defaultUnit" => { "id" => 91, "name" => "cup", "plural" => "cups" },
                      "foodId" => 20030,
                      "locale" => "en_US",
                      "name" => "Apple, Added Sugar, Dried",
                      "units" => [91, 256, 279, 226, 180, 147, 389]
                    }
                ]
            })
    end

    context 'created with a user with a linked account' do
      before(:each) do
        @user.stub(:present?).and_return(true)
        @user.stub(:linked?).and_return(true)
      end

      it 'calls the find_food method on the fitbit data client' do
        @user.fitbit_data.should_receive(:find_food)
        Fitbit::Food.search(@user, 'apple')
      end

      it 'passes the search term to the search method on the fitbit data client' do
        @user.fitbit_data.should_receive(:find_food).with('apple')
        Fitbit::Food.search(@user, 'apple')
      end

      it 'returns an array of Fitbit::Food instances' do
        foods = Fitbit::Food.search(@user, 'apple')
        foods.count.should eq(2)
      end

      it 'packages the returned data into Fitbit::Food instances' do
        apple = Fitbit::Food.search(@user, 'apple')[0]
        apple.class.should be(Fitbit::Food)
        apple.accessLevel.should eq('PUBLIC')
        apple.name.should eq('Apple')
        apple.id.should eq(81409)
      end
    end

    context 'created with a user without a linked account' do
      before(:each) do
        @user.stub(:present?).and_return(true)
        @user.stub(:linked?).and_return(false)
      end

      it 'does not call the find_food method on the fitbit data client' do
        @user.should_not_receive(:fitbit_data)
        Fitbit::Food.search(@user, 'apple')
      end

      it 'returns and empty array of results' do
        results = Fitbit::Food.search(@user, 'apple')
        results.class.should eq(Array)
        results.count.should eq(0)
      end
    end
  end
end