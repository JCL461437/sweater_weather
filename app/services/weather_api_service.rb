class WeatherApiService

  BASE_URL = "http://api.weatherapi.com"

  def self.conn 
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.headers['X-Api-Key'] = Rails.application.credentials.weather[:key]
      # faraday.params['key'] = Rails.application.credentials.weather[:key]
      faraday.adapter Faraday.default_adapter
    end
  end
end