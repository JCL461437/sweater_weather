require 'rails_helper'

require 'rails_helper'

RSpec.describe "POST /api/v1/road_trip endpoint" do
  describe 'happy path' do
    it 'returns a payload with road trip details' do
      user = User.create!( email: "theman@theman.com", password: "themanspassword", password_confirmation: "themanspassword")
      
      valid_request_payload = {
        start_city: "Cincinnati, OH",
        end_city: "Chicago, IL"
        api_key: user.api_key
      }

      post "/api/v1/road_trip", params: valid_request_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to eq(nil)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('road_trip')
      expect(json_response[:data]).to have_key(:attributes)

      expect(json_response[:data][:attributes]).to have_key(:start_city)
      expect(json_response[:data][:attributes][:start_city]).to eq("Cincinnati, OH")
      expect(json_response[:data][:attributes]).to have_key(:end_city)
      expect(json_response[:data][:attributes][:end_city]).to eq("Chicago, IL")
      expect(json_response[:data][:attributes]).to have_key(:travel_time)
      expect(json_response[:data][:attributes][:travel_time]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)

      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(json_response[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(json_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(json_response[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      expect(json_response[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'returns an error for missing start city' do
      user = User.create!( email: "theman@theman.com", password: "themanspassword", password_confirmation: "themanspassword")
      invalid_request_payload = {
        end_city: "Chicago, IL"
        api_key: user.api_key
      }

      post "/api/v1/road_trip", params: invalid_request_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      error_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_response).to have_key(:errors)
      expect(error_response[:errors]).to have_key(:status)
      expect(error_response[:errors][:status]).to eq('422')
      expect(error_response[:errors]).to have_key(:detail)
      expect(error_response[:errors][:detail]).to eq("Start city can't be blank")
    end

    it 'returns an error for missing end city' do
      user = User.create!( email: "theman@theman.com", password: "themanspassword", password_confirmation: "themanspassword")
      invalid_request_payload = {
        start_city: "Chicago, IL"
        api_key: user.api_key
      }

      post "/api/v1/road_trip", params: invalid_request_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      error_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_response).to have_key(:errors)
      expect(error_response[:errors]).to have_key(:status)
      expect(error_response[:errors][:status]).to eq('422')
      expect(error_response[:errors]).to have_key(:detail)
      expect(error_response[:errors][:detail]).to eq("End city can't be blank")
    end

    it 'returns an error for missing api key' do
      invalid_request_payload = {
        start_city: "Cincinnati, OH",
        end_city: "Chicago, IL"
      }

      post "/api/v1/road_trip", params: invalid_request_payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      error_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_response).to have_key(:errors)
      expect(error_response[:errors]).to have_key(:status)
      expect(error_response[:errors][:status]).to eq('422')
      expect(error_response[:errors]).to have_key(:detail)
      expect(error_response[:errors][:detail]).to eq("You must have a valid API key")
    end
  end
end
