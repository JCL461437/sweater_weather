class Api::V1::BookController < ApplicationController
  def book-search
    location = params[:location]
    quantity = params[:quantity]

    books = BookFacade.new.get_books(location, quantity)

    lat_long = MapQuestFacade.new.lat_long(location)
    weather_forecast = WeatherFacade.new.five_days_forecast(lat_long)
    
    render json: BookWeatherSerializer.books_and_weather(books, weather_forecast)
  end
end