class Api:V1:WeatherController < ApplicationController
  def forcast  
    location = params[:location] # pulled from query params for `/api/v1/forecast?location=Salt Lake City, UT`
    
  end
end