class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    origin = params[:origin]
    destination = params[:destination]

    MapQuestFacade.new.directions(origin, destination)

    
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end