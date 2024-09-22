class Api:V1:WeatherController < ApplicationController
  def forcast  
    location = params[:location] # pulled from query params for `/api/v1/forecast?location=Salt Lake City, UT`
    # {"lat":40.76031,"lng":-111.88822}
    @current_weather = WeatherApiService.current_weather(location)
    @five_days_forcast = WeatherApiService.get_five_days_forcast(location)
    # @hourly_weather = WeatherApiService.get_hourly_forcast

    render json: CurrentWeatherSerializer.all_weather(@current_weather, @five_days_forcast)
  end
end