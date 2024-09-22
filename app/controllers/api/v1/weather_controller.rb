class Api:V1:WeatherController < ApplicationController
  def forcast  
    location = params[:location] # pulled from query params for `/api/v1/forecast?location=Salt Lake City, UT`

    @current_weather = WeatherApiService.current_weather(location)
    @five_days_forcast = WeatherApiService.five_days_forcast(location)
    @hourly_weather = WeatherApiService.hourly_forcast
  end
end