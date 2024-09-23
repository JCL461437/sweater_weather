require 'rails_helper'

RSpec.describe CurrentWeather do
  describe '#initialize' do
    it 'instantiates a CurrentWeather object with the correct attributes from the JSON response' do
      json_data = File.read('spec/fixtures/current_slc_weather.json')
      parsed_data = JSON.parse(json_data, symbolize_names: true)
      
      current_weather = CurrentWeather.new(parsed_data)

      expect(current_weather).to be_a(CurrentWeather)
      expect(current_weather.location).to eq(parsed_data[:location])
      expect(current_weather.name).to eq(parsed_data[:location][:name])
      expect(current_weather.region).to eq(parsed_data[:location][:region])
      expect(current_weather.lat).to eq(parsed_data[:location][:lat])
      expect(current_weather.lon).to eq(parsed_data[:location][:lon])
      expect(current_weather.timezone).to eq(parsed_data[:location][:tz_id])
      expect(current_weather.localtime).to eq(parsed_data[:location][:localtime])

      expect(current_weather.current).to eq(parsed_data[:current])
      expect(current_weather.last_updated).to eq(parsed_data[:current][:last_updated])
      expect(current_weather.temperature).to eq(parsed_data[:current][:temp_f])
      expect(current_weather.condition).to eq(parsed_data[:current][:condition])
      expect(current_weather.text).to eq(parsed_data[:current][:condition][:text])
      expect(current_weather.icon).to eq(parsed_data[:current][:condition][:icon])
      expect(current_weather.humidity).to eq(parsed_data[:current][:humidity])
      expect(current_weather.feels_like).to eq(parsed_data[:current][:feelslike_f])
      expect(current_weather.visibility).to eq(parsed_data[:current][:vis_miles])
      expect(current_weather.uv).to eq(parsed_data[:current][:uv])
    end
  end
end
