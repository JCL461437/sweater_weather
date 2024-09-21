class WeatherApiService

  def self.conn 
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      # faraday.headers['X-Api-Key'] = Rails.application.credentials.weather[:key]
      faraday.params['key'] = Rails.application.credentials.weather[:key]
      faraday.adapter Faraday.default_adapter
    end
  end
end