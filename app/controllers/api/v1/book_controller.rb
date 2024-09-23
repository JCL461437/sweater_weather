class Api::V1::BookController < ApplicationController
  def book_search
    location = params[:location]
    quantity = params[:quantity]

    books = BookFacade.new.search_books(location, quantity)

    lat_long = MapQuestFacade.new.lat_long(location)
    weather_forecast = WeatherFacade.new.current_weather(lat_long)
    
    render json: BookWeatherSerializer.books_and_weather(books, weather_forecast)
  end
end