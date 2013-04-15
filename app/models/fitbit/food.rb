class Fitbit::Food < Fitbit::Data
  attr_accessor :accessLevel, :brand, :calories, :defaultServingSize, :defaultUnit, :id, :locale,
                :name, :units

  def initialize(food_data)
    @accessLevel = food_data['accessLevel']
    @brand = food_data['brand']
    @calories = food_data['calories']
    @defaultServingSize = food_data['defaultServingSize']
    @defaultUnit = food_data['defaultUnit']
    @id = food_data['foodId']
    @locale = food_data['locale']
    @name = food_data['name']
    @units = food_data['units']

    # Uncomment to view the data that is returned by the Fitbit service
    # ActiveRecord::Base.logger.info food_data
  end

  def self.search(user, search_term)
    food_results = []
    if user.present? && user.linked?
      foods = user.fitbit_data.find_food(search_term)['foods']
      food_results = foods.map{ |f| Fitbit::Food.new(f) }
    end
    food_results
  end
end