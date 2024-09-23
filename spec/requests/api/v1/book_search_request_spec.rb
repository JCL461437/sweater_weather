require 'rails_helper'

RSpec.describe "GET /api/v1/book-search?location=denver,co&quantity=5 endpoint" do
  describe 'happy path' do
    it 'can return a payload with city and quantity information' do
      
      lat_long = "40.76031,-111.88822"
      location = "Salt Lake City, UT"
      quantity = "3"
      
      json_weather_response = File.read('spec/fixtures/five_day_forcast_slc.json')
      stub_request(:get, "/v1/current.json?key=#{Rails.application.credentials.weather[:key]}&q=#{lat_long}").to_return(status: 200, body: json_weather_response)
      weather_response = JSON.parse(json_weather_response, symbolize_names: true)

      json_book_response = File.read('spec/fixtures/book_for_city.json') # includes limit/quantity of 3
      stub_request(:get, "/search.json?q=#{location}&place:#{location}&limit=#{quantity}").to_return(status: 200, body: json_book_response)
      book_response = JSON.parse(json_book_response, symbolize_names: true)
      
      weather_poros = CurrentWeather.new(weather_response)
      book_poros = Book.new(book_response)
      payload = BookWeatherSerializer.new(book_poros, weather_poros)

      expect(payload).to eq(File.read('spec/fixtures/book_weather.json'))
    end
  end

  describe "sad path" do 
    it "cannot return a payload without a location" do 
      
      lat_long = "40.76031,-111.88822"
      location = ""
      quantity = "3"

      json_weather_response = File.read('spec/fixtures/five_day_forcast_slc.json')
      weather_stub_request(:get, "/v1/current.json?key=#{Rails.application.credentials.weather[:key]}&q=#{lat_long}").to_return(status: 400, body: json_weather_response)
      weather_response = JSON.parse(json_weather_response, symbolize_names: true)

      json_book_response = File.read('spec/fixtures/book_for_city.json') # includes limit/quantity of 3
      book_stub_request(:get, "/search.json?q=#{location}&place:#{location}&limit=#{quantity}").to_return(status: 400, body: json_book_response)
      book_response = JSON.parse(json_book_response, symbolize_names: true)
      
      payload = ParametersErrorSerializer.new.location_error_json

      expect(payload[:errors]).to be_an(Array)
      expect(payload[:errors][0][:status]).to eq("422")
      expect(payload[:errors][0][:detail]).to eq("No location was provided, try again with a location")
    end

    it "cannot return a payload without a quantity" do 
      
      lat_long = "40.76031,-111.88822"
      location = "Salt Lake City"
      quantity = ""

      json_weather_response = File.read('spec/fixtures/five_day_forcast_slc.json')
      weather_stub_request(:get, "/v1/current.json?key=#{Rails.application.credentials.weather[:key]}&q=#{lat_long}").to_return(status: 400, body: json_weather_response)
      weather_response = JSON.parse(json_weather_response, symbolize_names: true)

      json_book_response = File.read('spec/fixtures/book_for_city.json') # includes limit/quantity of 3
      book_stub_request(:get, "/search.json?q=#{location}&place:#{location}&limit=#{quantity}").to_return(status: 400, body: json_book_response)
      book_response = JSON.parse(json_book_response, symbolize_names: true)
      
      payload = ParametersErrorSerializer.new.quantity_error_json

      expect(payload[:errors]).to be_an(Array)
      expect(payload[:errors][0][:status]).to eq("422")
      expect(payload[:errors][0][:detail]).to eq("No quantity was provided, try again with a quantity")
    end
  end
end