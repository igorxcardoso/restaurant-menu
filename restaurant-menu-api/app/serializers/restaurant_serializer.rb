class RestaurantSerializer

  def initialize(restaurant)
    @restaurant = restaurant
  end

  def as_json(*)
    {
      name: @restaurant.name,
      menus: @restaurant.menus.map {|m| ::MenuSerializer.new(m).as_json }
    }
  end
end
