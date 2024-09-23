class Api::V1::WeatherController < ApplicationController
  def forcast  
    location = params[:location] # pulled from query params for `/api/v1/forecast?location=Salt Lake City, UT`
    # {"lat":40.76031,"lng":-111.88822}

    # turns location from query params into lat and long using Map Quest API
    lat_long = MapQuestFacade.new.lat_long(location)
    # Retrieves current weather and forcast for hourly and five days using Weather API
    current_weather = WeatherFacade.new.current_weather(lat_long)
    five_days_forecast = WeatherFacade.new.five_days_forecast(lat_long)
    hourly_forecast = WeatherFacade.new.hourly_forecast(lat_long)

    render json: WeatherSerializer.all_weather(current_weather, five_days_forecast, hourly_forecast)
  end
end