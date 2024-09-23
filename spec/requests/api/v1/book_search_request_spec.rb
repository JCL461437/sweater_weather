require 'rails_helper'

RSpec.describe "GET /api/v1/book-search?location=denver,co&quantity=5 endpoint" do
  describe 'happy path' do
    it 'can return a payload with city and quantity information' do
      
      lat_long = "40.76031,-111.88822"
      location = "Salt Lake City, UT"
      quantity = "3"
      
      json_weather_response = File.read('spec/fixtures/five_day_forcast_slc.json')
      weather_response = JSON.parse(json_weather_response, symbolize_names: true)

      json_book_response = File.read('spec/fixtures/book_for_city.json') # includes limit/quantity of 3
      book_response = JSON.parse(json_book_response, symbolize_names: true)
      
      response = get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to eq(201)

      books = BookFacade.new.get_books(location, quantity)
      lat_long = MapQuestFacade.new.lat_long(location)
      weather_forecast = WeatherFacade.new.current_weather(lat_long)
      
      payload = BookWeatherSerializer.books_and_weather(books, weather_forecast)

      expect(payload).to eq(File.read('spec/fixtures/book_weather.json'))
    end
  end

  describe "sad path" do 
    it "cannot return a payload without a location" do 
      
      lat_long = "40.76031,-111.88822"
      location = ""
      quantity = "3"

      json_weather_response = File.read('spec/fixtures/five_day_forcast_slc.json')
      weather_response = JSON.parse(json_weather_response, symbolize_names: true)

      json_book_response = File.read('spec/fixtures/book_for_city.json') # includes limit/quantity of 3
      book_response = JSON.parse(json_book_response, symbolize_names: true)

      response = get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to eq(404)
      
      payload = ParametersErrorSerializer.location_error_json

      expect(payload).to_not eq(File.read('spec/fixtures/book_weather.json'))

      expect(payload[:errors]).to be_an(Array)
      expect(payload[:errors][0][:status]).to eq("422")
      expect(payload[:errors][0][:detail]).to eq("No location was provided, try again with a location")
    end

    it "cannot return a payload without a quantity" do 
      
      lat_long = "40.76031,-111.88822"
      location = "Salt Lake City"
      quantity = ""

      json_weather_response = File.read('spec/fixtures/five_day_forcast_slc.json')
      weather_response = JSON.parse(json_weather_response, symbolize_names: true)

      json_book_response = File.read('spec/fixtures/book_for_city.json') # includes limit/quantity of 3
      book_response = JSON.parse(json_book_response, symbolize_names: true)
      
      response = get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to eq(404)
      
      payload = ParametersErrorSerializer.quantity_error_json

      expect(payload).to_not eq(File.read('spec/fixtures/book_weather.json'))

      expect(payload[:errors]).to be_an(Array)
      expect(payload[:errors][0][:status]).to eq("422")
      expect(payload[:errors][0][:detail]).to eq("No quantity was provided, try again with a quantity")
    end
  end
end