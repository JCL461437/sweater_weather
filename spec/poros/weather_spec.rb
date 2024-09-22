require 'rails_helper'

RSpec.describe Weather do
  describe '#initialize' do
    it 'instantiates a CurrentWeather object with the correct attributes from the JSON response' do
      json = File.read('spec/fixtures/current_slc_weather.json')

      current_weather = CurrentWeather.new(json)

      expect(current_weather).to be_a CurrentWeather
      expect(current_weather.temperature).to eq(72.5)
      expect(current_weather.last_updated).to eq("2023-08-03 15:30")
      expect(current_weather.condition_text).to eq("Partly cloudy")
      expect(current_weather.condition_icon).to eq("//cdn.weatherapi.com/weather/64x64/day/116.png")
      expect(current_weather.feels_like).to eq(71.2)
      expect(current_weather.uvi).to eq(5)
      expect(current_weather.visibility).to eq(6)
      expect(current_weather.humidity).to eq(65)
    end
  end
end