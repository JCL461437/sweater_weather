class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    origin = params[:origin]
    destination = params[:destination]

    road_trip = MapQuestFacade.new.directions(origin, destination)

    RoadTripSerializer.new(road_trip)
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end