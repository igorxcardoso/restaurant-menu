require 'rails_helper'

RSpec.describe "Api::V1::Imports", type: :request do
  let(:fixture_path) { Rails.root.join('spec/fixtures/files/restaurant_data.json') }
  let(:payload) { JSON.parse(File.read(fixture_path)) }

  describe "POST /api/v1/imports" do
    it "imports JSON and returns logs" do
      post "/api/v1/imports", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['success']).to be true
      expect(json['logs']).to be_an(Array)
      expect(Restaurant.count).to eq(2)
    end

    it "returns bad request for invalid JSON" do
      # send as plain text so rack doesn't attempt to parse the body as JSON
      post "/api/v1/imports", params: 'not-json', headers: { 'CONTENT_TYPE' => 'text/plain' }
      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)
      expect(json['success']).to be false
      expect(json['error']).to eq('invalid_json')
    end
  end
end
