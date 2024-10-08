class WeatherApiService

  BASE_URL = "http://api.weatherapi.com"

  def self.connection
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.headers['X-Api-Key'] = Rails.application.credentials.weather[:key]
      # faraday.params['key'] = Rails.application.credentials.weather[:key]
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.get_current_weather(lat_long)
    response = connection.get("/v1/current.json?key=#{Rails.application.credentials.weather[:key]}&q=#{lat_long}") # do I need to send it in query params because of line 6-8?
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_five_days_forecast(lat_long)
    response = connection.get("/v1/forecast.json?key=#{Rails.application.credentials.weather[:key]}&q=#{lat_long}&days=5") # do I need to send it in query params because of line 6-8?
    
    JSON.parse(response.body, symbolize_names: true) #just use this to get whatever hourly forcast you want based off json response
  end

  # def self.hourly_forcast(location)
  #   response = connection.get("/v1/forecast.json?key=#{Rails.application.credentials.weather[:key]}&q=#{location}&hour=24") # do I need to send it in query params because of line 6-8?
    
  #   JSON.parse(response.body, symbolize_names: true)
  # end
end