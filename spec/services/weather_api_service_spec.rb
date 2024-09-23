require 'rails_helper'

RSpec.describe WeatherApiService do
  it 'can #get_current_weather' do
    json_response = File.read('spec/fixtures/current_slc_weather.json')
    stub_request(:get, "/v1/current.json?key=#{Rails.application.credentials.weather[:key]}&q=40.76031,-111.88822").to_return(status: 200, body: json_response)
    query = JSON.parse(json_response, symbolize_names: true)
    # query = MapQuestApiService.get_lat_long("Salt Lake City, UT")
  
    expect(query).to be_a(Hash)

    expect(query).to have_key(:location)
    expect(query[:location]).to be_a(Hash)

    expect(query[:location][:name]).to eq("Salt Lake City")
    expect(query[:location][:region]).to eq("Utah")
    expect(query[:location][:lat]).to eq(40.76)
    expect(query[:location][:lon]).to eq(-111.89)
    expect(query[:location][:localtime]).to eq("2024-09-22 16:08")


    expect(query).to have_key(:current)
    expect(query[:current]).to be_a(Hash)
    expect(query[:current][:last_updated]).to eq("2024-09-22 16:00")
    expect(query[:current][:temp_f]).to eq(77.5)
    expect(query[:current][:humidity]).to eq(29)
    expect(query[:current][:vis_miles]).to eq(9.0)


    expect(query[:current][:condition]).to be_a(Hash)
    expect(query[:current][:condition][:text]).to eq("Partly cloudy")
    expect(query[:current][:condition][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/116.png")

    expect(query[:current]).to_not have_key(:hour)
    expect(query[:current]).to_not have_key(:temp_c)
  end
end