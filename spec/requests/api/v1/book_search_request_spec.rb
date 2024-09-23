require 'rails_helper'

RSpec.describe "GET /api/v1/book-search?location=denver,co&quantity=5 endpoint" do
  describe 'happy path' do
    it 'can return a payload with city and quantity information' do
      
      location = "Salt Lake City, UT"
      quantity = "3"
      
      response = get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to eq(201)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:data)
      expect(payload[:data]).to have_key(:id)
      expect(payload[:data][:id]).to eq('null') 
      expect(payload[:data]).to have_key(:type)
      expect(payload[:data][:type]).to eq('books')
      expect(payload[:data]).to have_key(:attributes)
      
      expect(payload[:data][:attributes]).to have_key(:destination)
      expect(payload[:data][:attributes][:destination]).to eq('Salt Lake City')

      expect(payload[:data][:attributes]).to have_key(:forecast)
      expect(payload[:data][:attributes][:forecast]).to have_key(:summary)
      expect(payload[:data][:attributes][:forecast][:summary]).to be_a String
      expect(payload[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(payload[:data][:attributes][:forecast][:temperature]).to be_an Float

      expect(payload[:data][:attributes]).to have_key(:total_books_found)
      expect(payload[:data][:attributes][:total_books_found]).to be_a Integer 

      expect(payload[:data][:attributes]).to have_key(:books)
      expect(payload[:data][:attributes][:books]).to be_an(Array)
      expect(payload[:data][:attributes][:books].size).to be >= 1  # Ensure there are books
      
      payload_without_values = JSON.parse(File.read('spec/fixtures/raw_book_weather.json'), symbolize_names: true)

      expect(payload_without_values[:data][:attributes][:books][0]).to have_key(:isbn)
      expect(payload_without_values[:data][:attributes][:books][0]).to have_key(:title)
      expect(payload_without_values[:data][:attributes][:books][0]).to have_key(:publisher)

      expect(payload_without_values[:data][:attributes][:books][0][:isbn]).to include("ISBN value not available")
      expect(payload_without_values[:data][:attributes][:books][0][:title]).to eq("Salt Lake City")
      expect(payload_without_values[:data][:attributes][:books][0][:publisher]).to include("N. Doubleday")

      expect(payload).to eq(JSON.parse(File.read('spec/fixtures/raw_book_weather.json'), symbolize_names: true))
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

      expect(payload).to_not eq(File.read('spec/fixtures/raw_book_weather.json'))

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

      expect(payload).to_not eq(File.read('spec/fixtures/raw_book_weather.json'))

      expect(payload[:errors]).to be_an(Array)
      expect(payload[:errors][0][:status]).to eq("422")
      expect(payload[:errors][0][:detail]).to eq("No quantity was provided, try again with a quantity")
    end
  end
end