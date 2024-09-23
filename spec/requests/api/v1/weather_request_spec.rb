require 'rails_helper'

RSpec.describe "GET /api/v1/weather?location=users_location endpoint" do
  describe 'happy path' do
    it 'returns a payload with current, daily, and hourly weather information' do
      
      location = "salt lake city, ut"

      get "/api/v1/forecast?location=#{location}"

      expect(response).to have_http_status(:success)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:data)
      expect(payload[:data]).to have_key(:id)
      expect(payload[:data][:id]).to eq(nil) 
      expect(payload[:data]).to have_key(:type)
      expect(payload[:data][:type]).to eq('forecast')
      expect(payload[:data]).to have_key(:attributes)

      expect(payload[:data][:attributes]).to have_key(:current_weather)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(payload[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(payload[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(payload[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(payload[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:uv)
      expect(payload[:data][:attributes][:current_weather][:uv]).to be_a(Float)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(payload[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:condition_text)
      expect(payload[:data][:attributes][:current_weather][:condition_text]).to be_a(String)
      expect(payload[:data][:attributes][:current_weather]).to have_key(:condition_icon)
      expect(payload[:data][:attributes][:current_weather][:condition_icon]).to be_a(String)

      expect(payload[:data][:attributes]).to have_key(:daily_weather)
      expect(payload[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(payload[:data][:attributes][:daily_weather].size).to be > 0 

      expect(payload[:data][:attributes]).to have_key(:hourly_weather)
      expect(payload[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(payload[:data][:attributes][:hourly_weather].size).to be > 0
    end
  end

  describe "sad path" do 
    it "cannot return a payload without a location" do 
      
      location = ""

      get "/api/v1/forecast?location=#{location}"

      expect(response).to have_http_status(:unprocessable_entity)
      
      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:errors)
      expect(payload[:errors]).to be_an(Array)
      expect(payload[:errors].size).to eq(1)

      error = payload[:errors][0]
      expect(error).to have_key(:status)
      expect(error[:status]).to eq('422')
      expect(error).to have_key(:detail)
      expect(error[:detail]).to eq("No location was provided, try again with a location")
    end
  end
end
