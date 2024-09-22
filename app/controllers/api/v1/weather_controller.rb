class Api:V1:WeatherController < ApplicationController
  def forcast  
    location = params[:location] # pulled from query params for `/api/v1/forecast?location=Salt Lake City, UT`
    # {"lat":40.76031,"lng":-111.88822}

    # turns location from query params into lat and long using Map Quest API
    lat_long =  MapQuestApiService.get_lat_long(location)

    # Retrieves current weather and forcast for hourly and five days using Weather API
    @current_weather = WeatherApiService.current_weather(lat_long)
    @five_days_forcast = WeatherApiService.get_five_days_forcast(lat_long)

    render json: CurrentWeatherSerializer.all_weather(@current_weather)
    render json: FiveDaysForcastWeatherSerializer.all_weather(@five_days_forcast)
  end
end