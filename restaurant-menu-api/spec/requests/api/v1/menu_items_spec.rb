require 'rails_helper'

RSpec.describe "Api::V1::MenuItems", type: :request do
  describe "GET /index" do
    it "returns menu items for a menu" do
      menu = create(:menu)
      item = create(:menu_item)
      menu.menu_items << item

      get "/api/v1/menus/#{menu.id}/menu_items"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.first['name']).to eq(item.name)
    end
  end
end
