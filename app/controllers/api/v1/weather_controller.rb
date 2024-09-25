class Api::V1::WeatherController < ApplicationController
  def forecast  
    location = params[:location]
    if location.blank?
      render json: ParametersErrorSerializer.location_error_json, status: :unprocessable_entity
      return
    end

    lat_long = MapQuestFacade.new.lat_long(location)
    
    current_weather = WeatherFacade.new.current_weather(lat_long)
    five_days_forecast = WeatherFacade.new.five_days_forecast(lat_long)
    hourly_forecast = WeatherFacade.new.hourly_forecast(lat_long)

    render json: WeatherSerializer.all_weather(current_weather, five_days_forecast, hourly_forecast)
  end
end