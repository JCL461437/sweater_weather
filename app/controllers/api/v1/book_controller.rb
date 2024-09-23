class Api::V1::BookController < ApplicationController
  def book_search
    location = params[:location]
    quantity = params[:quantity]

    if location == nil
      render json: ParametersErrorSerializer.location_error_json, status: 422
    elsif quantity == nil
      render json: ParametersErrorSerializer.quantity_error_json, status: 422
    end

    if location && quantity != nil
      books = BookFacade.new.get_books(location, quantity)

      lat_long = MapQuestFacade.new.lat_long(location)
      weather_forecast = WeatherFacade.new.current_weather(lat_long)
      
      render json: BookWeatherSerializer.books_and_weather(books, weather_forecast)
    end
  end
end