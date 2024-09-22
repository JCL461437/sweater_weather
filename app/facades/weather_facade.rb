class WeatherFacade
  def current_weather(lat_long)
    json = WeatherApiService.get_current_weather(lat_long) # hitting methods in service
    CurrentWeather.new(json)
  end

  def five_days_forecast(lat_long)
    json = WeatherApiService.get_five_days_forecast(lat_long) # hitting methods in service

    json[:forecast][:forecastday].map do |forecasted_day| # iterating through json array
      FiveDaysForcastWeather.new(forecasted_day) # making poros
    end
  end

  # def get_hourly_forecast(lat_long)
  #   json = WeatherApiService.get_five_days_forecast(lat_long) # hitting methods in service

  #   json[:forecast][:forecastday][0][:hour].map do |forecasted_hour|
  #     HourForecastWeather.new(forecasted_hour)
  #   end
  # end
end