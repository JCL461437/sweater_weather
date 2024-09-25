class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    origin = params[:origin]
    destination = params[:destination]

    
    if destination.blank?
      render json: ParametersErrorSerializer.location_error_json, status: :unprocessable_entity
      return
    end

    destination_lat_long = MapQuestFacade.new.lat_long(destination)
    five_days_forecast = WeatherFacade.new.five_days_forecast(destination_lat_long)
    road_trip = MapQuestFacade.new.directions(origin, destination)

    RoadTripSerializer.new.road_trip(road_trip, five_days_forecast)
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end