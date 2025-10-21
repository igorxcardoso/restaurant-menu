class Api::V1::RestaurantsController < ApplicationController

  # GET /api/v1/restaurants
  def index
    @restaurants = Restaurant.includes(menus: :menu_items).all
    render json: { restaurants: @restaurants.map{|r| RestaurantSerializer.new(r).as_json} }
  end

  # GET /api/v1/restaurants/:id
  def show
    @restaurant = Restaurant.find(params[:id])
    render json: RestaurantSerializer.new(@restaurant).as_json
  end
end
