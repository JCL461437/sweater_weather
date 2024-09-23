class BookWeatherSerializer
  include JSONAPI::Serializer
  
  def self.books_and_weather(books, weather_forecast)
    {
      "data": {
        "id": "null",
        "type": "books",
        "attributes": {
          "destination": weather_forecast.name,
          "forecast": {
            "summary": weather_forecast.text,
            "temperature": weather_forecast.temperature 
          },
          "total_books_found": books.total_books_found,
          "books": books.books.map do |book|
            book_creator(book)
          end
        }
      }
    }
  end
  
  def self.book_creator(book)
    {
      "isbn": book[:isbn],
      "title": book[:title],
      "publisher": book[:publisher]
    }
  end    
end
