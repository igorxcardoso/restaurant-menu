require 'rails_helper'

RSpec.describe "Api::V1::Menus", type: :request do
  describe "GET /index" do
    it "returns a list of menus" do
      menu = create(:menu)
      get "/api/v1/menus"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.first['name']).to eq(menu.name)
    end
  end

  describe "GET /show" do
    it "returns a single menu" do
      menu = create(:menu)
      get "/api/v1/menus/#{menu.id}"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['name']).to eq(menu.name)
    end
  end

end
