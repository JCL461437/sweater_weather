require "rails_helper"

RSpec.describe WeatherFacade do
  it "will make a poros from the json using the current_weather method" do
    lat_long = "40.76031,-111.88822" #slc lat long values 

    response = WeatherFacade.new.current_weather(lat_long)

    expect(response).to be_a(CurrentWeather)
  end
  
  it "will make a FiveDaysForecastWeather from the json using the five_days_forecast method" do
    lat_long = "40.76031,-111.88822"

    response = WeatherFacade.new.five_days_forecast(lat_long)

    expect(response).to be_a(Array)

    expect(response[0]).to be_a(FiveDaysForecastWeather)

    expect(response.count).to eq(5)
  end

  it "will make a HourForecastWeather poros from the json using the get_hourly_forecast method" do
    lat_long = "40.76031,-111.88822"

    response = WeatherFacade.new.hourly_forecast(lat_long)

    expect(response).to be_a(Array)

    expect(response[0]).to be_a(HourForecastWeather)

    expect(response.count).to eq(24)
  end
end
