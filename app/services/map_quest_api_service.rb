class WeatherApiService

  def self.conn 
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address") do |faraday|
      faraday.params['key'] = Rails.application.credentials.map_quest[:key]
      faraday.adapter Faraday.default_adapter
    end
  end
end