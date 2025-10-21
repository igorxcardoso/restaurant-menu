require 'rails_helper'

RSpec.describe "Api::V1::Restaurants", type: :request do
  describe "GET /index" do
    it "returns a list of restaurants with menus and menu_items" do
      restaurant = create(:restaurant)
      menu = create(:menu, restaurant: restaurant)
      item = create(:menu_item)
      menu.menu_items << item

      get "/api/v1/restaurants"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json).to include('restaurants')
      expect(json['restaurants'].first['name']).to eq(restaurant.name)
    end
  end

  describe "GET /show" do
    it "returns a single restaurant" do
      restaurant = create(:restaurant)
      get "/api/v1/restaurants/#{restaurant.id}"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['name']).to eq(restaurant.name)
    end
  end
end
