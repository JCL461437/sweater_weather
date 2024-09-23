require 'rails_helper'

RSpec.describe "GET /api/v1/book-search?location=denver,co&quantity=5 endpoint" do
  it 'can return city, forecast, and book information' do
    
    lat_long = "40.76031,-111.88822"
    location = "Salt Lake City, UT"
    quantity = 3
    
    json_weather_response = File.read('spec/fixtures/five_day_forcast_slc.json')
    stub_request(:get, "/v1/current.json?key=#{Rails.application.credentials.weather[:key]}&q=#{lat_long}").to_return(status: 200, body: json_response)
    weather_response = JSON.parse(json_weather_response, symbolize_names: true)

    json_book_response = File.read('spec/fixtures/book_for_city.json')
    stub_request(:get, "/search.json?q=#{location}&place:#{location}&limit=#{quantity}").to_return(status: 200, body: json_response)
    book_response = JSON.parse(json_book_response, symbolize_names: true)
    
  end
end